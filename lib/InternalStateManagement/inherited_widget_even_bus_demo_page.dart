
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InheritedWidgetEventBusDemoPage extends StatefulWidget {
  final String title;

  InheritedWidgetEventBusDemoPage({Key key, this.title}) : super(key: key);

  @override
  _InheritedWidgetEventBusDemoPageState createState() => _InheritedWidgetEventBusDemoPageState();
}

class _InheritedWidgetEventBusDemoPageState extends State<InheritedWidgetEventBusDemoPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    bus.on(EventBus.incrementEvent, (_) {
      _incrementCounter();
    });
  }

  @override
  void dispose() {
    bus.off(EventBus.incrementEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CounterInheritedWidget(
      counter: _counter,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
              _IncrementButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _IncrementButton extends StatelessWidget {
  _IncrementButton();

  @override
  Widget build(BuildContext context) {
    final counter = CounterInheritedWidget.of(context).counter;
    return GestureDetector(
        onTap: () => bus.emit(EventBus.incrementEvent),
        child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("$counter", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),)
    );
  }
}

/// CounterInheritedWidget

class CounterInheritedWidget extends InheritedWidget {
  final int counter;

  // 需要在子树中共享的数据，保存点击次数
  CounterInheritedWidget({@required this.counter, Widget child}) : super(child: child);

  // 定义一个便捷方法，方便子树中的widget获取共享数据
  static CounterInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>();
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget old) {
    // 如果返回true，则子树中依赖(build函数中有调用)本widget
    // 的子widget的`state.didChangeDependencies`会被调用
    return old.counter != counter;
  }
}

/// EventBus

typedef void EventCallback(arg);

class EventBus {
  static const String incrementEvent = "incrementEvent";

  //私有构造函数
  EventBus._internal();

  //保存单例
  static EventBus _singleton = new EventBus._internal();

  // 工厂构造函数
  factory EventBus()=> _singleton;

  // 保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap = new Map<Object, List<EventCallback>>();

  // 添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= new List<EventCallback>();
    _emap[eventName].add(f);
  }

  // 移除订阅者
  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  // 触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    // 反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

var bus = new EventBus();
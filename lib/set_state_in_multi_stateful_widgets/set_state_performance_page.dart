
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetStatePerformancePage extends StatefulWidget {
  final String title;

  SetStatePerformancePage({Key key, this.title}) : super(key: key);

  @override
  _SetStatePerformancePageState createState() => _SetStatePerformancePageState();
}

class _SetStatePerformancePageState extends State<SetStatePerformancePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("BCQ: page rebuild");
    return CounterInheritedWidget(
      counter: _counter,
      child: NotificationListener<IncrementNotification>(
        onNotification: (notification) {
          print("BCQ: Notification = ${notification.msg}");
          setState(() {
            _incrementCounter();
          });
          return true;  // true: 阻止冒泡；false: 继续冒泡
        },
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
                _PerformanceButton(),
                _IncrementButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// _IncrementButton

class _IncrementButton extends StatefulWidget {
  @override
  _IncrementButtonState createState() => _IncrementButtonState();
}

class _IncrementButtonState extends State<_IncrementButton> {
  @override
  Widget build(BuildContext context) {
    final counter = CounterInheritedWidget.of(context).counter;
    return GestureDetector(
        onTap: () => IncrementNotification("加一").dispatch(context),
        child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("$counter", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),)
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("BCQ: _IncrementButton didChangeDependenies");
  }
}

/// _PerformanceButton

class _PerformanceButton extends StatefulWidget {
  @override
  _PerformanceButtonState createState() => _PerformanceButtonState();
}

class _PerformanceButtonState extends State<_PerformanceButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: null,
        child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("性能", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),)
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("BCQ: _PerformanceButton didChangeDependenies");
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

/// IncrementNotification

class IncrementNotification extends Notification {
  final String msg;
  IncrementNotification(this.msg);
}
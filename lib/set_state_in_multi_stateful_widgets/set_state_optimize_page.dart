
import 'package:flutter/cupertino.dart';


import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetStateOptimizePage extends StatefulWidget {
  final String title;

  SetStateOptimizePage({Key key, this.title}) : super(key: key);

  @override
  _SetStateOptimizePageState createState() => _SetStateOptimizePageState();
}

class _SetStateOptimizePageState extends State<SetStateOptimizePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("BCQ: page rebuild");
    return InheritedProvider<int>(
      data: _counter,
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
    return GestureDetector(
        onTap: () => IncrementNotification("加一").dispatch(context),
        child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("$", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),)
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

/// IncrementNotification

class IncrementNotification extends Notification {
  final String msg;
  IncrementNotification(this.msg);
}

/// InheritedProvider

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    // 在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

/// ChangeNotifier

class ChangeNotifier implements Listenable {
  List listeners = [];
  @override
  void addListener(listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(listener) {
    listeners.remove(listener);
  }

  void notifyListeners() {
    listeners.forEach((item) => item());
  }
}

/// ChangeNotifierProvider

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({Key key, this.data, this.child});

  final Widget child;
  final T data;

  static T of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider> {
  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.data.addListener(update);
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}
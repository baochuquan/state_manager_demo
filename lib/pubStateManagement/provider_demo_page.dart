
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderDemoPage extends StatefulWidget {
  final String title;

  ProviderDemoPage({Key key, this.title}) : super(key: key);

  @override
  _ProviderDemoPageState createState() => _ProviderDemoPageState();
}

class _ProviderDemoPageState extends State<ProviderDemoPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterProviderState>(
      create: (_) => CounterProviderState(),
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
              Consumer<CounterProviderState>(builder: (context, counter, _) => Text("${counter.value}", style: Theme.of(context).textTheme.display1)),
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
    final _counter = Provider.of<CounterProviderState>(context);
    return GestureDetector(
        onTap: () => _counter.incrementCounter(),
        child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("${_counter.value}", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),)
    );
  }
}

/// CounterProviderState

class CounterProviderState with ChangeNotifier {
  int _counter = 0;
  int get value => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PubProviderPage extends StatefulWidget {
  final String title;

  PubProviderPage({Key key, this.title}) : super(key: key);

  @override
  _PubProviderPageState createState() => _PubProviderPageState();
}

class _PubProviderPageState extends State<PubProviderPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterModel>(
      create: (_) => CounterModel(),
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
              Consumer<CounterModel>(builder: (context, counter, _) => Text("${counter.value}", style: Theme.of(context).textTheme.display1)),
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
    final _counter = Provider.of<CounterModel>(context);
    return GestureDetector(
        onTap: () => _counter.incrementCounter(),
        child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("${_counter.value}", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),)
    );
  }
}

/// CounterModel

class CounterModel with ChangeNotifier {
  int _counter = 0;
  int get value => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlocDemoPage extends StatefulWidget {
  final String title;

  BlocDemoPage({Key key, this.title}) : super(key: key);

  @override
  _BlocDemoPageState createState() => _BlocDemoPageState();
}

class _BlocDemoPageState extends State<BlocDemoPage> {
  final bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    print("HHHH: build");
    return BlocProvider(
      bloc: bloc,
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
              StreamBuilder<int>(stream: bloc.value, initialData: 0, builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text("${snapshot.data}", style: Theme.of(context).textTheme.display1);
              },),
              _IncrementButton(),
            ],
          ),
        ),
      )
    );
  }
}

class _IncrementButton extends StatelessWidget {
  _IncrementButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => BlocProvider.of(context).increment(),
        child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: StreamBuilder<int>(stream: BlocProvider.of(context).value, initialData: 0, builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Text("${snapshot.data}", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white));
        },),),)
    );
  }
}

/// scoped bloc provider

class BlocProvider extends InheritedWidget {
  final CounterBloc bloc;

  BlocProvider({this.bloc, Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CounterBloc of(BuildContext context) => (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
}

/// CounterBloc

class CounterBloc {
  int _counter;
  StreamController<int> _counterController;

  CounterBloc() {
    _counter = 0;
    _counterController = StreamController<int>.broadcast();
  }

  Stream<int> get value => _counterController.stream;

  increment() {
    _counterController.sink.add(++_counter);
  }

  dispose() {
    _counterController.close();
  }

}
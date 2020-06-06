
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ReduxDemoPage extends StatefulWidget {
  final String title;

  ReduxDemoPage({Key key, this.title}) : super(key: key);

  @override
  _ReduxDemoPageState createState() => _ReduxDemoPageState();
}

class _ReduxDemoPageState extends State<ReduxDemoPage> {
  final store = Store<CounterReduxState>(reducer, initialState: CounterReduxState.initState());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CounterReduxState>(
      store: store,
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
              StoreConnector<CounterReduxState, int>(
                converter: (store) => store.state.value,
                builder: (context, count) {
                  return Text("$count", style: Theme.of(context).textTheme.display1);
                },
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
    return StoreConnector<CounterReduxState, VoidCallback>(
      converter: (store) {
        return () => store.dispatch(Action.increment);
      },
      builder: (context, callback) {
        return GestureDetector(
            onTap: callback,
            child: StoreConnector<CounterReduxState, int>(
              converter: (store) => store.state.value,
              builder: (context, count) {
                return ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("$count", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),);
              },
            )
        );
      },
    );
  }
}

/// State: CounterReduxState

class CounterReduxState {
  int _counter = 0;
  int get value => _counter;

  CounterReduxState(this._counter);

  CounterReduxState.initState() {
    _counter = 0;
  }
}

/// Action

enum Action{
  increment
}

/// Reducer
CounterReduxState reducer(CounterReduxState state, dynamic action) {
  if (action == Action.increment) {
    return CounterReduxState(state.value + 1);
  }
  return state;
}

/// Store
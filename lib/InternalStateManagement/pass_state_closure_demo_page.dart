
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PassStateClosureDemoPage extends StatefulWidget {
  final String title;

  PassStateClosureDemoPage({Key key, this.title}) : super(key: key);

  @override
  _PassStateClosureDemoPageState createState() => _PassStateClosureDemoPageState();
}

class _PassStateClosureDemoPageState extends State<PassStateClosureDemoPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _IncrementButton(_counter, _incrementCounter),
          ],
        ),
      ),
    );
  }
}

class _IncrementButton extends StatelessWidget {
  int counter = 0;
  Function closure;

  _IncrementButton(this.counter, this.closure);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => closure(),
      child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("$counter", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),)
    );
  }
}

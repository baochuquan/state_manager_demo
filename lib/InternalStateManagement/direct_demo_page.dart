
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DirectDemoPage extends StatefulWidget {
  final String title;

  DirectDemoPage({Key key, this.title}) : super(key: key);

  @override
  _DirectDemoPageState createState() => _DirectDemoPageState();
}

class _DirectDemoPageState extends State<DirectDemoPage> {
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
            GestureDetector(
                onTap: _incrementCounter,
                child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("$_counter", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),)
            )
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PassStateNotificationDemoPage extends StatefulWidget {
  final String title;

  PassStateNotificationDemoPage({Key key, this.title}) : super(key: key);

  @override
  _PassStateNotificationDemoPageState createState() => _PassStateNotificationDemoPageState();
}

class _PassStateNotificationDemoPageState extends State<PassStateNotificationDemoPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<IncrementNotification>(
      onNotification: (notification) {
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
              _IncrementButton(_counter),
            ],
          ),
        ),
      ),
    );
  }
}

class _IncrementButton extends StatelessWidget {
  int counter = 0;

  _IncrementButton(this.counter);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => IncrementNotification("加一操作").dispatch(context),
        child: ClipOval(child: Container(width: 50, height: 50, alignment: Alignment.center,color: Colors.blue, child: Text("$counter", textAlign: TextAlign.center,style: TextStyle(fontSize: 24, color: Colors.white),),),)
    );
  }
}

/// IncrementNotification

class IncrementNotification extends Notification {
  final String msg;
  IncrementNotification(this.msg);
}
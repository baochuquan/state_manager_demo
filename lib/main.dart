import 'package:flutter/material.dart';
import 'package:statemanagerdemo/InternalStateManagement/pass_state_closure_demo_page.dart';
import 'package:statemanagerdemo/InternalStateManagement/inherited_widget_even_bus_demo_page.dart';
import 'package:statemanagerdemo/InternalStateManagement/inherited_widget_notification_demo_page.dart';
import 'package:statemanagerdemo/InternalStateManagement/pass_state_notification_demo_page.dart';
import 'package:statemanagerdemo/InternalStateManagement/direct_demo_page.dart';
import 'package:statemanagerdemo/pubStateManagement/bloc_demo_page.dart';
import 'package:statemanagerdemo/pubStateManagement/provider_demo_page.dart';
import 'package:statemanagerdemo/pubStateManagement/redux_demo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    return BlocProvider(
//      bloc: CounterBloc(),
//      child: MaterialApp(
//        title: 'Flutter Demo',
//        theme: ThemeData(
//          // This is the theme of your application.
//          //
//          // Try running your application with "flutter run". You'll see the
//          // application has a blue toolbar. Then, without quitting the app, try
//          // changing the primarySwatch below to Colors.green and then invoke
//          // "hot reload" (press "r" in the console where you ran "flutter run",
//          // or simply save your changes to "hot reload" in a Flutter IDE).
//          // Notice that the counter didn't reset back to zero; the application
//          // is not restarted.
//          primarySwatch: Colors.blue,
//        ),
//        home: HomePage(title: '状态管理'),
//      ),
//    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: '状态管理'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // Flutter 内置的状态管理方案
            buildEntry(context, DirectDemoPage(title: "直接访问 + 直接更新"), "直接访问 + 直接更新"),
            buildEntry(context, PassStateClosureDemoPage(title: "状态传递 + 闭包传递"), "状态传递 + 闭包传递"),
            buildEntry(context, PassStateNotificationDemoPage(title: "状态传递 + Notification"), "状态传递 + Notification"),
            buildEntry(context, InheritedWidgetNotificationDemoPage(title: "InheritedWidget + Notification"), "InheritedWidget + Notification"),
            buildEntry(context, InheritedWidgetEventBusDemoPage(title: "InheritedWidget + EventBus"), "InheritedWidget + EventBus"),
            // 基于 Pub 的状态管理方案
            buildEntry(context, ProviderDemoPage(title: "Provider"), "Provider"),
            buildEntry(context, ReduxDemoPage(title: "Redux"), "Redux"),
            buildEntry(context, BlocDemoPage(title: "BLoC"), "BLoC"),
          ]),
        ));
  }

  Center buildEntry(BuildContext context, Widget page, String title) {
    return Center(
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => page));
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: TextStyle(fontSize: 17),
              ),
            )));
  }
}

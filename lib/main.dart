import 'package:flutter/material.dart';
import 'package:statemanagerdemo/set_state_in_multi_stateful_widgets/set_state_block_page.dart';
import 'package:statemanagerdemo/set_state_in_multi_stateful_widgets/set_state_even_bus_inherited_widget_page.dart';
import 'package:statemanagerdemo/set_state_in_multi_stateful_widgets/set_state_inherited_widget_notification_page.dart';
import 'package:statemanagerdemo/set_state_in_multi_stateful_widgets/set_state_optimize_page.dart';
import 'package:statemanagerdemo/set_state_in_multi_stateful_widgets/set_state_performance_page.dart';
import 'package:statemanagerdemo/set_state_in_multi_stateful_widgets/set_state_notification_page.dart';
import 'package:statemanagerdemo/set_state_in_one_stateful_widget/set_state_page.dart';
import 'package:statemanagerdemo/with_provider/pub_provider_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildEntry(context, SetStatePage(title: "SetState"), "setState - 单一StatefuleWidget"),
              buildEntry(context, SetStateBlockPage(title: "SetState - Block"), "setState - 多层级Widget"),
              buildEntry(context, SetStateNotificationPage(title: "SetState - Notification"), "setState - 多层级Widget"),
              buildEntry(context, SetStateInheritedWidgetNotificationPage(title: "SetState - InheritedWidget & Notification"), "setState - 多层级Widget"),
              buildEntry(context, SetStateEvenBusInheritedWidgetPage(title: "SetState - EventBus & InheritedWidget",), "setState - 多层级Widget"),
              buildEntry(context, SetStatePerformancePage(title: "Performance",), "性能"),
              buildEntry(context, PubProviderPage(title: "Pub Provider",), "Pub Provider"),
            ]
        ),
      )
    );
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
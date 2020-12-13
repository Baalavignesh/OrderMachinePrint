import 'package:flutter/material.dart';
import 'package:printblue/screens/FinishedOrders.dart';
import 'package:printblue/screens/GetOrdersScreen.dart';

class MainTabScreen extends StatefulWidget {
  static const String id = "MainTabScreen";
  @override
  _MainTabScreenState createState() => _MainTabScreenState();
  Duration get transitionDuration => const Duration(milliseconds: 1000);
}

class _MainTabScreenState extends State<MainTabScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(
            'Your Store',
            style: TextStyle(fontSize: 22),
          ),
          bottom: TabBar(
            indicatorColor: Colors.greenAccent,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            controller: controller,
            tabs: <Tab>[
              new Tab(text: 'New Orders', icon: new Icon(Icons.new_releases)),
              new Tab(
                  text: 'Completed Orders', icon: new Icon(Icons.check_circle)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: controller,
          children: [
            GetOrdersScreen(),
            FinishedOrders(),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:printblue/screens/GetOrdersScreen.dart';
import 'package:printblue/screens/HomeScreen.dart';
import 'package:printblue/screens/MainTabScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bluetooth demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        MainTabScreen.id: (context) => MainTabScreen(),
      },
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:onlineprint/screens/HomeScreen.dart';
//import 'package:onlineprint/screens/LoadingScreen.dart';
//import 'package:onlineprint/screens/OrderScreen.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: HomeScreen(),
//      theme: ThemeData(
//        fontFamily: 'Roboto',
//      ),
//      routes: {
//        HomeScreen.id: (context) => HomeScreen(),
//        LoadingScreen.id: (context) => LoadingScreen(),
//        OrderScreen.id: (context) => OrderScreen(),
//      },
//    );
//  }
//}

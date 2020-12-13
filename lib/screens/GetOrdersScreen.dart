import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:printblue/constants.dart';
import 'package:printblue/reusables/NewOrders.dart';
import 'package:printblue/screens/HomeScreen.dart';
import 'package:printblue/services/BluetoothPrinter.dart';
import 'package:printblue/services/getOrderAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetOrdersScreen extends StatefulWidget {
  static const String id = "GetOrdersScreen";
  @override
  _GetOrdersScreenState createState() => _GetOrdersScreenState();
}

class _GetOrdersScreenState extends State<GetOrdersScreen> {
  var orders = [];

  String url =
      "https://virtserver.swaggerhub.com/grocerySOS/getNewOrders/1.0.0/order";

  Future getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String printerName = (prefs.getString('printerName'));
    String printerAddress = (prefs.getString('printerAddress'));
    PrinterBluetooth myPrinter;
    for (var i in deviceList) {
      if (i.name == printerName && i.address == printerAddress) {
        myPrinter = i;
        print(myPrinter.runtimeType);
      }
    }
    var getOrders = await GetOrder(url: url).getOrders();
    setState(() {
      orders = getOrders;
    });
    BluetoothPrinter().testPrint(myPrinter);
    print(orders);
    print(orders[0]);
    print(orders[0]['id']);
    print(orders[0]['orderItems'][0]['quantity']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: orders.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int i) {
            return NewOrders(url: url, orderId: orders[i]['id']);
          }),
    );

//    return Container(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//
//          Center(
//            child: Text(
//              'Orders will Automatically Print',
//              style: TextStyle(fontSize: 25),
//            ),
//          ),
//          FlatButton(
//            child: Text('print again'),
//            color: Colors.blueAccent,
//            onPressed: () async {
//              print('printing again');
//              await getOrders();
//            },
//          )
//        ],
//      ),
//    );

//      Scaffold(
//      appBar: AppBar(
//        title: Text('Get New Orders'),
//        actions: <Widget>[
//          GestureDetector(
//            onTap: () async {
//              SharedPreferences prefs = await SharedPreferences.getInstance();
//              await prefs.setString('printerName', null);
//              await prefs.setString('printerAddress', null);
//              Navigator.pushReplacementNamed(context, MyHomePage.id);
//            },
//            child: Container(
//              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//              child: Icon(Icons.refresh),
//            ),
//          )
//        ],
//      ),
//      body:
//    );
  }
}

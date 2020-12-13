import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:printblue/screens/GetOrdersScreen.dart';
import 'package:printblue/screens/MainTabScreen.dart';
import 'package:printblue/services/BluetoothPrinter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class MyHomePage extends StatefulWidget {
  static const String id = "MyHomePage";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  bool newPrinter = false;

  @override
  void initState() {
    super.initState();
    print('running');
    try {
      printerManager.scanResults.listen((devices) async {
        print('UI: Devices found ${devices.length}');
        setState(() {
          deviceList = devices;
        });
      }).onError(() => {print('There is an Error')});
    } catch (e) {
      print(e);
    }

    _startScanDevices();
  }

  void _startScanDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String printerName = (prefs.getString('printerName'));
    String printerAddress = (prefs.getString('printerAddress'));
    print('$printerAddress and $printerName');
    if (printerAddress == null && printerName == null) {
      setState(() {
        newPrinter = true;
      });
      print("showing the list of printer");
      try {
        print('Starting Scan');
        printerManager.startScan(Duration(seconds: 4));
      } catch (e) {
        print('Scan Failed');

        print(e);
      }
    } else {
      printerManager.startScan(Duration(seconds: 4));
      Future.delayed(Duration(seconds: 5), () async {
        printerManager.stopScan();
        Navigator.pushReplacementNamed(context, MainTabScreen.id);
      });
    }

    setState(() {
      deviceList = [];
    });
  }

  void _stopScanDevices() {
    printerManager.stopScan();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checking for Printer'),
      ),
      body: newPrinter
          ? ListView.builder(
              itemCount: deviceList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => BluetoothPrinter()
                      .savePrinter(deviceList[index], context),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.print),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(deviceList[index].name ?? ''),
                                  Text(deviceList[index].address),
                                  Text(
                                    'Click to Save Printer',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              })
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Column(
                  children: <Widget>[
                    Text(
                      'Printer Found',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Loading...',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SpinKitRotatingPlain(
                      color: Colors.greenAccent,
                      size: 50.0,
                    ),
                  ],
                )),
              ],
            ),
    );
  }
}

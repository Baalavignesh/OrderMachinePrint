import 'package:flutter/material.dart';

class FinishedOrders extends StatefulWidget {
  static const String id = 'FinishedOrdersScreen';
  @override
  _FinishedOrdersState createState() => _FinishedOrdersState();
}

class _FinishedOrdersState extends State<FinishedOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Finished orders',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

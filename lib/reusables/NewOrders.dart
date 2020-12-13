import 'package:flutter/material.dart';
import 'package:printblue/services/getOrderAPI.dart';

class NewOrders extends StatefulWidget {
  final orderId;
  final url;
  NewOrders({this.orderId, this.url});

  @override
  _NewOrdersState createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  this.widget.orderId,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print(this.widget.url);
                  print(this.widget.url + '/' + this.widget.orderId);
                  String newUrl = this.widget.url + '/' + this.widget.orderId;
                  print('remove from new orders and update api');
                  GetOrder(url: newUrl).updateOrder();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Icon(
                    Icons.check_circle,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

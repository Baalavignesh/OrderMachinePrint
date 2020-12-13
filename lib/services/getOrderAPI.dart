import 'package:http/http.dart' as http;
import 'dart:convert';

class GetOrder {
  final url;
  GetOrder({this.url});

  Future getOrders() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print("Response StatusCode : ");
      print(response.statusCode);
    }
  }

  Future updateOrder() async {
    http.Response response = await http.put(url,
        body: jsonEncode(<String, String>{
          "id": "ORD-123",
          "changeDateTime": "2016-08-29T09:12:33Z",
          "orderStatus": "OrderCreated",
          "paymentStatus": "PaymentReceived"
        }));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print("Response StatusCode : ${response.statusCode}");
    }
  }
}

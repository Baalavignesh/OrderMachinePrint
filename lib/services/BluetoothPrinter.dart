import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:printblue/constants.dart';
import 'package:printblue/screens/GetOrdersScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BluetoothPrinter {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();

  Future<Ticket> demoReceipt(PaperSize paper) async {
    final Ticket ticket = Ticket(paper);

//     TOP Part
    ticket.text('hi',
        styles: PosStyles(
          align: PosAlign.center,
//          height: PosTextSize.size2,
//          width: PosTextSize.size2,
        ),
        linesAfter: 1);

//    ticket.text('Customer ID : ${orders[0]['customerId']}',
//        styles: PosStyles(align: PosAlign.center));
//    ticket.text('Vendor ID : ${orders[0]['vendorId']}',
//        styles: PosStyles(align: PosAlign.center));
//    ticket.text('Delivery Window : ${orders[0]['deliveryWindow']}',
//        styles: PosStyles(align: PosAlign.center));
//    ticket.text('Pickup Window : ${orders[0]['pickupWindow']}',
//        styles: PosStyles(align: PosAlign.center), linesAfter: 1);
//
//    ticket.hr();
//    ticket.row([
//      PosColumn(text: 'Qty', width: 2),
//      PosColumn(text: 'Item', width: 5),
//      PosColumn(
//          text: 'Size', width: 2, styles: PosStyles(align: PosAlign.right)),
//      PosColumn(
//          text: 'Total', width: 3, styles: PosStyles(align: PosAlign.right)),
//    ]);
//
//    for (int i = 0; i < orders[0]['orderItems'].length; i++) {
//      ticket.row([
//        PosColumn(
//            text: orders[0]['orderItems'][i]['quantity'].toString(), width: 2),
//        PosColumn(text: orders[0]['orderItems'][i]['name'], width: 5),
//        PosColumn(
//            text: orders[0]['orderItems'][i]['size'] +
//                ' ' +
//                orders[0]['orderItems'][i]['unit'],
//            width: 2,
//            styles: PosStyles(align: PosAlign.right)),
//        PosColumn(
//            text: orders[0]['orderItems'][i]['price'].toString(),
//            width: 3,
//            styles: PosStyles(align: PosAlign.right)),
//      ]);
//    }
//
//    ticket.hr();
//
//    ticket.row([
//      PosColumn(
//          text: 'TOTAL ',
//          width: 6,
//          styles: PosStyles(
//            height: PosTextSize.size2,
//            width: PosTextSize.size2,
//          )),
//      PosColumn(
//          text: 'Rs.${orders[0]['totalAmount']}',
//          width: 6,
//          styles: PosStyles(
//            align: PosAlign.right,
//            height: PosTextSize.size2,
//            width: PosTextSize.size2,
//          )),
//    ]);
//
//    ticket.hr(ch: '=', linesAfter: 1);
//
//    ticket.feed(2);
//    ticket.text('Thank you!',
//        styles: PosStyles(align: PosAlign.center, bold: true));
//
//    ticket.text(orders[0]['orderDate'],
//        styles: PosStyles(align: PosAlign.center), linesAfter: 2);

    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

  void savePrinter(PrinterBluetooth printer, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('printerName', printer.name);
    await prefs.setString('printerAddress', printer.address);
    Navigator.pushReplacementNamed(context, GetOrdersScreen.id);
  }

  void testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;

    // DEMO RECEIPT
    final PosPrintResult res =
        await printerManager.printTicket(await demoReceipt(paper));

    print(res.msg);
    if (res.msg != 'Success') {
      print('printer not working');
    }
  }
}

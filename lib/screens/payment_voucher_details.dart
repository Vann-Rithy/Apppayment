import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'checkrequest.dart'; // Import the new file

class PaymentVoucherDetailsPage extends StatefulWidget {
  @override
  _PaymentVoucherDetailsPageState createState() =>
      _PaymentVoucherDetailsPageState();
}

class _PaymentVoucherDetailsPageState extends State<PaymentVoucherDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Payment Voucher Details',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 0, 36, 143),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 12, 3, 151)!,
                Color.fromARGB(255, 1, 30, 160)!
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: 120, // Assuming 120 items for the example
              itemBuilder: (context, index) {
                return PaymentVoucherCard(
                  index: index,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckRequestPage(index: index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}

class PaymentVoucherCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;

  const PaymentVoucherCard({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightBlueAccent,
          child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
        ),
        title: Text('Payment Voucher #$index'),
        subtitle: Text('Details for Payment Voucher #$index'),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.lightBlueAccent),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Voucher extends StatefulWidget {
  const Voucher({Key key}) : super(key: key);

  @override
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          SizedBox(height: 30.0),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: Colors.white),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [Text('Voucher')],
                )),
          ))
        ]));
  }
}

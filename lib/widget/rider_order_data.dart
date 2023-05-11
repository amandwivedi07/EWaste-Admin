import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiderReportData extends StatefulWidget {
  final String? riderUid;
  final String? date;

  const RiderReportData({this.date, this.riderUid, Key? key}) : super(key: key);

  @override
  State<RiderReportData> createState() => _RiderReportDataState();
}

final now = DateTime.now();
String time = DateFormat('dd-MM-yyyy').format(now);

class _RiderReportDataState extends State<RiderReportData> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
        stream: _services.orders
            .where('orderType', isEqualTo: 'Delivery')
            .where('deliveryBoy.riderUid', isEqualTo: widget.riderUid)
            .where('cod', isEqualTo: true)
            // .where('date', isEqualTo: widget.date ?? '')
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went Wrong');
            // print(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No order on this data'),
            );
          }

          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return Row(
                  children: [
                    _userData(flex: 1, widget: Text((index + 1).toString())),
                    _userData(flex: 1, text: data['date']),
                    _userData(flex: 1, text: data['userName']),
                    _userData(flex: 1, text: data['orderId'].toString()),
                    _userData(flex: 1, text: data['total'].toString()),
                    _userData(flex: 1, text: data['deliveryFee'].toString()),
                    _userData(
                        flex: 1, text: data['deliveryBoy']['name'].toString()),
                    _userData(
                        flex: 1,
                        widget: ElevatedButton(
                            onPressed: () {
                              var x = snapshot.data!.docs
                                  .fold(0, (p, e) => e['total'] + p);
                              _services.showMyDialog(
                                  title: 'Cash',
                                  context: context,
                                  message: 'Total Cash $x');
                            },
                            child: Text('Get Total Cash'))),
                    _userData(
                        flex: 1,
                        widget: ElevatedButton(
                            onPressed: () {
                              var y = snapshot.data!.docs
                                  .fold(0, (p, e) => e['deliveryFee'] + p);
                              _services.showMyDialog(
                                  title: 'Delivery Fee',
                                  context: context,
                                  message: 'Total Delivery Cash $y');
                            },
                            child: const Text('Get Delivery Cash'))),
                  ],
                );
              });
        });
  }
}

Widget _userData({int? flex, String? text, Widget? widget}) {
  return Expanded(
    flex: flex!,
    child: Container(
      // width: 80,
      height: 60,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: widget ??
              Text(
                text!,
                style: TextStyle(fontSize: 15),
              )),
    ),
  );
}

alertDialog({context, title, content}) {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

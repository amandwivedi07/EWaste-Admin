import 'dart:html';

import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../delivery/delivery_boy_list.dart';
import 'order_detail_box.dart';

class OrderData extends StatefulWidget {
  const OrderData({Key? key}) : super(key: key);

  @override
  State<OrderData> createState() => _OrderDataState();
}

class _OrderDataState extends State<OrderData> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String time = DateFormat('dd-MM-yyyy').format(now);
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
        stream: _services.orders
            .where('orderType', isEqualTo: 'Delivery')
            .where('date', isEqualTo: time)
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
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return Row(
                  children: [
                    _userData(flex: 1, widget: Text((index + 1).toString())),

                    _userData(flex: 1, text: data['userName']),
                    _userData(flex: 1, text: data['orderId'].toString()),

                    _userData(flex: 1, text: data['seller']['shopName']),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: statusColor(data),
                              border: Border.all(color: Colors.grey.shade400)),
                          child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                data['orderStatus'],
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              )),
                        )),

                    _userData(
                        flex: 1,
                        text: DateFormat()
                            .format(DateTime.parse(data['timeStamp']))),
                    // if (document['deliveryBoy']['name'].length > 2)

                    _userData(flex: 1, text: data['deliveryBoy']['name']),

                    _userData(
                        flex: 1,
                        widget: data['deliveryBoy']['name'].length == 0
                            ? ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                onPressed: () {
                                  if (data['orderStatus'] == 'Ordered') {
                                    alertDialog(
                                        context: context,
                                        title: 'Order Update',
                                        content:
                                            'Ask Vendor to Prepare the Order');
                                  } else if (data['orderStatus'] ==
                                      'Preparing') {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DeliveryBoysList(
                                            data,
                                            data['seller']['sellerId'],
                                          );
                                        });
                                  } else {
                                    alertDialog(
                                        context: context,
                                        title: 'Order Update',
                                        content: 'Already Appointed the rider');
                                  }
                                },
                                child: const Text(
                                  'Appoint Rider',
                                  style: TextStyle(color: Colors.white),
                                ))
                            : ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  if (data['orderStatus'] == 'Ordered') {
                                    alertDialog(
                                        context: context,
                                        title: 'Order Update',
                                        content:
                                            'Ask Vendor to Prepare the Order');
                                  } else if (data['orderStatus'] ==
                                          'Preparing' ||
                                      data['orderStatus'] ==
                                          'Rider Appointed') {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DeliveryBoysList(
                                            data,
                                            data['seller']['sellerId'],
                                          );
                                        });
                                  } else {
                                    alertDialog(
                                        context: context,
                                        title: 'Order Update',
                                        content: 'Already Appointed the rider');
                                  }
                                },
                                child: const Text('Change Rider',
                                    style: TextStyle(color: Colors.white)))),

                    _userData(
                        flex: 1,
                        widget: ElevatedButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return OrderDetailBox(
                                        userId: data['userId']);
                                  });
                            },
                            child: const Text(
                              'View More',
                              textAlign: TextAlign.center,
                            ))),
                  ],
                );
              });
        });
  }

  Color? statusColor(DocumentSnapshot document) {
    if (document['orderStatus'] == 'Preparing') {
      return Colors.blue;
    }
    if (document['orderStatus'] == 'Rejected') {
      return Colors.red;
    }
    if (document['orderStatus'] == 'Picked Up') {
      return Colors.pink[900];
    }

    if (document['orderStatus'] == 'On The way') {
      return Colors.purple[900];
    }
    if (document['orderStatus'] == 'Delivered') {
      return Colors.green;
    }

    return Colors.orange;
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
}

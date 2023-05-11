import 'package:admin/models/orders.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:admin/widget/order_detail_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PastOrderData extends StatefulWidget {
  const PastOrderData({Key? key}) : super(key: key);

  @override
  State<PastOrderData> createState() => _PastOrderDataState();
}

class _PastOrderDataState extends State<PastOrderData> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
        stream:
            _services.orders.orderBy('timeStamp', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              Orders orders = Orders.fromJson(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>);

              return Row(
                children: [
                  _userData(flex: 1, widget: Text((index + 1).toString())),
                  _userData(flex: 1, text: orders.userName),
                  _userData(flex: 1, text: orders.orderId.toString()),
                  _userData(flex: 1, text: orders.shopName),
                  _userData(flex: 1, text: orders.orderStatus),
                  _userData(
                      flex: 1,
                      widget: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return OrderDetailBox(userId: orders.userId);
                                });
                          },
                          child: const Text(
                            'View More',
                            textAlign: TextAlign.center,
                          ))),
                ],
              );
            },
          );
        });
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
}

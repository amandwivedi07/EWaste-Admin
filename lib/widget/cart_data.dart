import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cart_item_info.dart';

class CartData extends StatefulWidget {
  const CartData({Key? key}) : super(key: key);

  @override
  State<CartData> createState() => _CartDataState();
}

class _CartDataState extends State<CartData> {
  final FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _services.cart.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went Wrong');
            // print(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return Row(
                  children: [
                    _userData(flex: 1, widget: Text((index + 1).toString())),
                    _userData(flex: 1, text: data['shopName']),
                    _userData(
                        flex: 1,
                        widget: TextFormField(
                          controller: TextEditingController(text: data['user']),
                        )),
                    _userData(
                        flex: 1,
                        widget: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CartItemDetailBox(
                                        createdAt: data['timeStamp'] != null
                                            ? DateFormat().format(
                                                DateTime.parse(
                                                    data['timeStamp']))
                                            : '',
                                        userId: data['user']);
                                  });
                            },
                            child: const Text(
                              'Item Info',
                              textAlign: TextAlign.center,
                            ))),
                  ],
                );
              });
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

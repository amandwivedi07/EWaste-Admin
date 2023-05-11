import 'dart:math';

import 'package:admin/models/user.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'order_detail_box.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
        stream:
            _services.users.orderBy('createdAt', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(e.toString());
            return const Text('Something went Wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              // Map<String, dynamic> data =
              //     snapshot.data!.docs[index].data() as Map<String, dynamic>;
              User user = User.fromJson(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>);
              var date = user.time;
              var time = DateFormat.yMMMd().add_jm().format(date!.toDate());

              return Row(
                children: [
                  _userData(flex: 1, widget: Text((index + 1).toString())),
                  _userData(flex: 2, text: user.name),
                  _userData(flex: 2, text: user.address),
                  _userData(flex: 1, text: user.phone),
                  _userData(flex: 1, text: time),
                  _userData(
                      flex: 1,
                      widget: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return OrderDetailBox(userId: user.name);
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
            padding: const EdgeInsets.all(4), child: widget ?? Text(text!)),
      ),
    );
  }
}

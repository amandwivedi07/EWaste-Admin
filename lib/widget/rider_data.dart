import 'package:admin/models/riders.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:admin/widget/rider_detailbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RiderData extends StatelessWidget {
  static const String id = 'Vendor';
  final bool? approveStatus;
  const RiderData({this.approveStatus, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();

    return StreamBuilder<QuerySnapshot>(
        stream: _services.riders
            .where('accVerified', isEqualTo: approveStatus)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            // return Text(snapshot.error.toString());
            return const Text('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          if (snapshot.data!.size == 0) {
            return const Center(
                child: Text(
              'No Riders to show',
              style: const TextStyle(fontSize: 22),
            ));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              Riders rider = Riders.fromJson(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>);

              return Row(
                children: [
                  _vendorData(flex: 1, text: rider.name),
                  _vendorData(flex: 1, text: rider.address),
                  _vendorData(flex: 1, text: rider.phone),
                  _vendorData(
                      flex: 1,
                      widget: rider.accVerified == true
                          ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                EasyLoading.show();
                                _services.updateListing(
                                    data: {'accVerified': false},
                                    docName: rider.riderUid,
                                    reference:
                                        _services.riders).then(
                                    (value) => {EasyLoading.dismiss()});
                              },
                              child: const Text(
                                'Reject',
                                style: TextStyle(color: Colors.white),
                              ))
                          : ElevatedButton(
                              onPressed: () {
                                EasyLoading.show();
                                _services.updateListing(
                                    data: {
                                      'accVerified': true,
                                    },
                                    docName: rider.riderUid,
                                    reference: _services.riders).then((value) {
                                  EasyLoading.dismiss();
                                });
                              },
                              child: const Text('Approve',
                                  style: TextStyle(color: Colors.white)))),
                  _vendorData(
                      flex: 1,
                      widget: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RiderDetailBox(
                                    rider: rider,
                                  );
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

  Widget _vendorData({int? flex, String? text, Widget? widget}) {
    return Expanded(
      flex: flex!,
      child: Container(
        // width: 80,
        height: 60,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: widget ?? Text(text!),
        ),
      ),
    );
  }
}

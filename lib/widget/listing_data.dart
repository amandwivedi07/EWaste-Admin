import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/listing.dart';
import '../screens/listing_detailBox.dart';

class ListingData extends StatefulWidget {
  const ListingData({Key? key}) : super(key: key);

  @override
  State<ListingData> createState() => _ListingDataState();
}

class _ListingDataState extends State<ListingData> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
        stream: _services.listing
            .orderBy('createdAt', descending: true)
            .snapshots(),
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
              Listing listing = Listing.fromDoc(snapshot.data!.docs[index]);
              var date = listing.time;

              var time = DateFormat.yMMMd().add_jm().format(date!.toDate());

              return Row(
                children: [
                  _userData(flex: 1, widget: Text((index + 1).toString())),
                  _userData(flex: 1, text: listing.componentName),
                  _userData(flex: 1, text: listing.listingStatus),
                  _userData(flex: 1, text: time),
                  _userData(
                      flex: 1,
                      widget: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ListingDetailBox(
                                    listing: listing,
                                    docId: snapshot.data!.docs[index].id,
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

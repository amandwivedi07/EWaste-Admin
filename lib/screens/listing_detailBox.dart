import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../constants.dart';
import '../models/listing.dart';
import '../services/firebase_services.dart';
import 'image_slider.dart';

class ListingDetailBox extends StatelessWidget {
  final Listing listing;
  final String docId;

  ListingDetailBox({required this.listing, required this.docId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    String? selectedStatus;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Dialog(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      listing.componentName!,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      listing.materialType!,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ImageSlider(
                      images: listing.images,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      listing.listingStatus!,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Dialog(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 400,
                                          width: 600,
                                          child: Center(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                value: selectedStatus,

                                                hint: Text(
                                                  'Listing Status',
                                                ),
                                                // dropdownColor: textFieldFillColor,
                                                // focusColor: textFieldFillColor,
                                                isExpanded: true,
                                                items: [
                                                  for (String status
                                                      in mylistingstatus.keys)
                                                    DropdownMenuItem(
                                                      child: Text(
                                                          mylistingstatus[
                                                              status]!),
                                                      value: status,
                                                    )
                                                ],
                                                onChanged: (value) => setState(
                                                  () {
                                                    selectedStatus =
                                                        value.toString();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              EasyLoading.show();
                                              _services.updateListing(
                                                  data: {
                                                    'listingStatus':
                                                        selectedStatus
                                                  },
                                                  docName: docId,
                                                  reference: _services
                                                      .listing).then((value) {
                                                EasyLoading.dismiss();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text('Update Listing '))
                                      ],
                                    ),
                                  );
                                });
                              });
                        },
                        child: const Text(
                          'View More',
                          textAlign: TextAlign.center,
                        ))
                  ],
                )
                // SizedBox(
                //   height: MediaQuery.of(context).size.height,
                //   width: MediaQuery.of(context).size.width * .3,
                //   child: const Center(
                //       child: Text(
                //     'No Orders Till Now',
                //     style: TextStyle(fontSize: 26),
                //   )),
                // )
              ]))),
    );
  }
}

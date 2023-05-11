import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

import '../models/listing.dart';

class UpdateListingStatus extends StatefulWidget {
  final Listing listing;

  UpdateListingStatus({required this.listing, Key? key}) : super(key: key);

  @override
  State<UpdateListingStatus> createState() => _UpdateListingStatusState();
}

class _UpdateListingStatusState extends State<UpdateListingStatus> {
  @override
  Widget build(BuildContext context) {
    String? selectedStatus;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Dialog(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                            for (String status in mylistingstatus.keys)
                              DropdownMenuItem(
                                child: Text(mylistingstatus[status]!),
                                value: status,
                              )
                          ],
                          onChanged: (value) => setState(
                            () {
                              selectedStatus = value.toString();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {}, child: Text('Update Listing '))
                ],
              ))),
    );
  }
}

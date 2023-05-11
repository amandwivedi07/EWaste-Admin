import 'package:flutter/material.dart';

import '../widget/listing_data.dart';

class ListingScreen extends StatelessWidget {
  static const String id = 'Listing';
  const ListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Listings',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              children: [
                _rowHeader(flex: 1, text: 'SN'),
                _rowHeader(flex: 1, text: 'Component Name'),
                _rowHeader(flex: 1, text: 'Listing Status'),
                _rowHeader(flex: 1, text: 'Created At'),
                _rowHeader(flex: 1, text: 'View More'),
              ],
            ),
            const ListingData()
          ]),
    );
  }

  Widget _rowHeader({int? flex, String? text}) {
    return Expanded(
      flex: flex!,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500),
            color: Colors.grey.shade400),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

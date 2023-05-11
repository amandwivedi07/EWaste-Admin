import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0xff35B237);

const kVendorDetailsTextStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w700);

String dateToReadable(DateTime date) {
  return '${DateFormat.d('en_US').format(date)} ${DateFormat.yMMM('en_US').format(date)}, ${DateFormat("hh:mma").format(date.toLocal())}';
}

const Map<String, String> mylistingstatus = {
  'Rider Appointed': 'Rider Appointed',
  'Enroute to Hub': 'Enroute to Hub',
  'Reached Hub': 'Reached Hub',
  'Disassembled and segragated': 'Disassembled and segragated',
  'Industry alloted': 'Industry alloted',
  'Delivered to industry': 'Delivered to industry',
};

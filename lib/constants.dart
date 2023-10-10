import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0xff967bb6);

const kVendorDetailsTextStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w700);

String dateToReadable(DateTime date) {
  return '${DateFormat.d('en_US').format(date)} ${DateFormat.yMMM('en_US').format(date)}, ${DateFormat("hh:mma").format(date.toLocal())}';
}

const Color darkGreenColor = Color(0xff1F9875);
const Color locationyellowColor = Color(0xffFFCA10);
const Color scaffoldBackgroundColor = Colors.white;
const Color borderColor = Color(0xffE0E0E0);
const Color borderSideColor = Color(0xffEAEAEA);
const Color hintTextColor = Color(0xffC3C3CA);
const Color textFieldFillColor = Color(0xffF6F6FA);

const Map<String, String> mylistingstatus = {
  'Rider Appointed': 'Rider Appointed',
  'Enroute to Hub': 'Enroute to Hub',
  'Reached Hub': 'Reached Hub',
  'Disassembled and segragated': 'Disassembled and segragated',
  'Industry alloted': 'Industry alloted',
  'Delivered to industry': 'Delivered to industry',
};

const Map<String, String> subCats = {
  'Topwear': 'Topwear',
  'Bottomwear': 'Bottomwear',
  'Footwear': 'Footwear',
  'Accessories': 'Accessories'
};

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFormField extends StatelessWidget {
  bool? enabled = true;
  int? maxLines;
  String? phone;
  final TextInputFormatter inputFormatter;
  TextEditingController? controller;
  String? label;
  final String? hintText;
  TextInputType? type;
  final IconData? data;
  String? Function(String?)? validator;
  void Function()? onPressed;
  Widget? suffixIcon;

  MyFormField(
      {this.enabled = true,
      this.maxLines,
      this.phone,
      required this.inputFormatter,
      this.controller,
      this.label,
      this.hintText,
      this.type,
      this.data,
      this.validator,
      this.suffixIcon,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [inputFormatter],
        enabled: enabled,
        maxLines: maxLines,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.black54,
          ),
          focusColor: Theme.of(context).primaryColor,
          labelText: label,
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }
}

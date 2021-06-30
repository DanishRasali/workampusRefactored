import 'package:flutter/material.dart';

import 'colors.dart';

Container awesomeTextField(
  TextEditingController controller,
  String hintText,
  int minLines,
  int maxLines,
  double width,
  TextInputType type,
  String error,
) {
  return Container(
    width: width,
    child: TextFormField(
      autocorrect: false,
      // ignore: missing_return
      validator: (val) {
        if (val.isEmpty) {
          return ('Please insert ' + error);
        }
      },
      controller: controller,
      keyboardType: type,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(
          color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black38, fontSize: 14.0, fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        filled: true,
        contentPadding:
            EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: dividerColor, width: 0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    ),
  );
}

Container awesomeTextFieldNoError(
  TextEditingController controller,
  String hintText,
  int minLines,
  int maxLines,
  double width,
  TextInputType type,
) {
  return Container(
    width: width,
    child: TextFormField(
      autocorrect: false,
      // ignore: missing_return

      controller: controller,
      keyboardType: type,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(
          color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black38, fontSize: 14.0, fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        filled: true,
        contentPadding:
            EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: dividerColor, width: 0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    ),
  );
}



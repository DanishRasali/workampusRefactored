import 'package:flutter/material.dart';

Container awesomeDivider(double thickness, Color color, {double width}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      border: Border.symmetric(

        horizontal: BorderSide(
          width: thickness,
          color: color,
        ),
      ),
    ),
  );
}
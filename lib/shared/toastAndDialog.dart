import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workampus/shared/textField.dart';

import 'colors.dart';

Future awesomeToast(String text) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future awesomeDialog(
    BuildContext context, String title, String desc, onPressed) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            content: Text(desc,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.justify),
            actions: [
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                      color: buttonGreenColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: onPressed,
              ),
            ],
            elevation: 15.0,
          ));
}

Future awesomeDoubleButtonDialog(
    BuildContext context,
    String title,
    String desc,
    String leftButton,
    onPressedLeft,
    String rightButton,
    onPressedRight) {
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            content: Text(desc,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.justify),
            actions: [
              FlatButton(
                child: Text(
                  leftButton,
                  style: TextStyle(
                      color: accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: onPressedLeft,
              ),
              FlatButton(
                child: Text(
                  rightButton,
                  style: TextStyle(
                      color: buttonGreenColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: onPressedRight,
              ),
            ],
            elevation: 15.0,
          ));
}

Future awesomeSingleDialog(
    BuildContext context, String title, String desc, onPressed) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            content: Text(desc,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
            actions: [
              FlatButton(
                child: Text(
                  'Got it!',
                  style: TextStyle(
                      color: buttonGreenColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: onPressed,
              ),
            ],
            elevation: 15.0,
          ));
}

Future awesomeInputDialog(BuildContext context, String title, String desc,
    TextEditingController controller, onPressed, String hint) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            content: SizedBox(
              height: 156,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(desc,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center),
                  awesomeTextField(
                    controller,
                    hint,
                    1,
                    1,
                    200,
                    TextInputType.number,
                    'charges',
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  'Withdraw',
                  style: TextStyle(
                      color: buttonGreenColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: onPressed,
              ),
            ],
            elevation: 15.0,
          ));
}

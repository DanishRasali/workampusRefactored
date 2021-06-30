// import 'package:dulang_new/models/profile.dart';
// import 'package:dulang_new/shared/styles.dart';
// import 'package:dulang_new/shared/toast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/initialScreen/signup_viewmodel.dart';
import 'package:workampus/shared/buttons.dart';
import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/styles.dart';
// import 'package:dulang_new/pages/home.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = '',
      displayName = '',
      address = '',
      password = '',
      roles = 'Job Seeker';
  bool visible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedRoles = 'Job Seeker';

  var _userRoles = ['Job Seeker', 'Job Provider'];

  var _currentRolesSelected = 'Job Seeker';

  // void initState() {
  //   super.initState();
  //   _myRoles = '';
  //   // _myRolesResult = '';
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final backButton = Container(
      height: 40.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 1.0),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Text('Go Back',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
          ),
        ),
      ),
    );

    return ViewModelBuilder<SignupViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: primaryColor,
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      15.0, 110.0, 0.0, 0.0),
                                  child: Text(
                                    'Signup',
                                    style: TextStyle(
                                        color: themeColor,
                                        fontSize: 80.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      302.0, 111.0, 0.0, 0.0),
                                  child: Text(
                                    '.',
                                    style: TextStyle(
                                        fontSize: 80.0,
                                        fontWeight: FontWeight.bold,
                                        color: accentColor),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autocorrect: false,
                            decoration: InputDecoration(
                                labelText: 'ENTER EMAIL',
                                labelStyle: greyBoldText,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(247, 178, 167, 1)))),
                            // ignore: missing_return
                            validator: (val) {
                              if (val.isEmpty ||
                                  !val.contains('@') ||
                                  !val.contains('.')) {
                                return ('Please enter a valid email address');
                              }
                            },
                            onChanged: (val) => setState(() => email = val),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            autocorrect: false,
                            decoration: InputDecoration(
                                labelText: 'ENTER NICKNAME',
                                labelStyle: greyBoldText,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(247, 178, 167, 1)))),
                            // ignore: missing_return
                            validator: (val) {
                              if (val.isEmpty) {
                                return ('Please enter nickname');
                              }
                            },
                            onChanged: (val) =>
                                setState(() => displayName = val),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            autocorrect: false,
                            decoration: InputDecoration(
                                labelText: 'ENTER LOCATION',
                                labelStyle: greyBoldText,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(247, 178, 167, 1)))),
                            // ignore: missing_return
                            validator: (val) {
                              if (val.isEmpty) {
                                return ('Please enter location');
                              }
                            },
                            onChanged: (val) => setState(() => address = val),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            autocorrect: false,
                            obscureText: !visible,
                            decoration: InputDecoration(
                              labelText: 'CREATE PASSWORD',
                              labelStyle: greyBoldText,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(247, 178, 167, 1))),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    visible
                                        ? Icons.visibility
                                        : Icons.visibility_off_outlined,
                                    color: visible
                                        ? Colors.black54
                                        : Colors.black38),
                                onPressed: () =>
                                    setState(() => visible = !visible),
                              ),
                            ),
                            // ignore: missing_return
                            validator: (input) {
                              if (input.isEmpty) {
                                return ('Please enter password');
                              } else if (input.length < 6) {
                                return ('password must be above 6 characters');
                              }
                            },
                            onChanged: (val) => setState(() => password = val),
                          ),
                          SizedBox(height: 50.0),
                          Container(
                            width: screenWidth,
                            child: Row(
                              children: [
                                Text(
                                  'SELECT ROLES:',
                                  style: TextStyle(
                                      color: grey,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.5),
                                ),
                                Spacer(),
                                Container(
                                  child: DropdownButton<String>(
                                    underline: Container(),
                                    items: _userRoles
                                        .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Container(
                                              child: Text(
                                                dropDownStringItem + " ",
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontSize: 16.5,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    icon: Transform.rotate(
                                        angle: 90 * pi / 180,
                                        child: Icon(Icons.chevron_right,
                                            color: Colors.black54)),
                                    onChanged: (String newRolesSelected) {
                                      setState(() {
                                        _currentRolesSelected =
                                            newRolesSelected;
                                        roles = _currentRolesSelected;
                                      });
                                    },
                                    value: _currentRolesSelected,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.0),
                          BusyButton(
                            height: 40.0,
                            busy: model.isBusy,
                            title: 'SIGNUP',
                            onPressed: () async {
                              print('signing up...');
                              print('email = ' + email);
                              print('displayName = ' + displayName);
                              print('address = ' + address);
                              if (_formKey.currentState.validate())
                                model.register(
                                  email: email,
                                  displayName: displayName,
                                  address: address,
                                  password: password,
                                  roles: roles,
                                  context: context,
                                );
                            },
                          ),
                          SizedBox(height: 15.0),
                          backButton,
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/shared/buttons.dart';
// import 'package:workampus/services/auth_service.dart';
import 'package:workampus/shared/colors.dart';

import 'package:workampus/shared/styles.dart';

import 'login_viewmodel.dart';
import 'signup_view.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '', password = '';
  bool visible = false;
  // final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => LoginViewModel(),
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
                    builtHelloThereText(),
                    Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autocorrect: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: greyBoldText,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: accentColor))),
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
                            obscureText: !visible,
                            decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: greyBoldText,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    visible
                                        ? Icons.visibility
                                        : Icons.visibility_off_outlined,
                                    color: visible
                                        ? Colors.black54
                                        : Colors.black38,
                                  ),
                                  onPressed: () =>
                                      setState(() => visible = !visible),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: accentColor))),
                            validator: (val) =>
                                val.isEmpty ? 'Password is empty' : null,
                            onChanged: (val) => setState(() => password = val),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            alignment: Alignment(1.0, 0.0),
                            padding: EdgeInsets.only(top: 15.0, left: 20.0),
                            child: InkWell(
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    color: accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          BusyButton(
                            height: 40.0,
                            busy: model.isBusy,
                            title: 'LOGIN',
                            onPressed: () async {
                              if (_formKey.currentState.validate())
                                model.signIn(
                                    email: email,
                                    password: password,
                                    context: context);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'New to Workampus?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: accentColor,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container builtHelloThereText() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
            child: Text('Hello',
                style: TextStyle(
                    color: themeColor,
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
            child: Text('There',
                style: TextStyle(
                    color: themeColor,
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(248.0, 175.0, 0.0, 0.0),
            child: Text('.',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: accentColor)),
          )
        ],
      ),
    );
  }
}

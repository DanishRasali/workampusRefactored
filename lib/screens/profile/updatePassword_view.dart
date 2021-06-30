import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/profile/profile_view.dart';
import 'package:workampus/screens/profile/profile_viewmodel.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({this.user});
  final User user;

  @override
  _UpdatePasswordViewState createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  TextEditingController curPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController rNewPassController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool checkCurrentPasswordValid = true;

  bool cVisible = false;
  bool nVisible = false;
  bool rnVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder<ProfileViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Change Password'),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      color: bgColor,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter your current password:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          buildPasswordField(
                            screenWidth,
                            curPassController,
                            cVisible,
                            () => setState(() => cVisible = !cVisible),
                            (val) {
                              if (val.isEmpty) {
                                return ('Please enter current password');
                              } else if (!checkCurrentPasswordValid) {
                                return ('Please double check your current password');
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 15, right: 15),
                      color: bgColor,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter new password:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          buildPasswordField(
                            screenWidth,
                            newPassController,
                            nVisible,
                            () => setState(() => nVisible = !nVisible),
                            (val) {
                              if (val.isEmpty) {
                                return ('Please enter new password');
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 15, right: 15),
                      color: bgColor,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Re-enter new password:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          buildPasswordField(
                            screenWidth,
                            rNewPassController,
                            rnVisible,
                            () => setState(() => rnVisible = !rnVisible),
                            (val) {
                              if (val.isEmpty) {
                                return ('Please re-enter new password');
                              } else if (rNewPassController.text !=
                                  newPassController.text) {
                                return ('New Password unmatched!');
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: transparentButton("Change", () async {
                        checkCurrentPasswordValid = await model
                            .validateCurrentPassword(curPassController.text);

                        setState(() {});

                        if (_formKey.currentState.validate() &&
                            checkCurrentPasswordValid) {
                          model.updatePassword(newPassController.text);
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ProfileView()));
                          awesomeToast('Password Changed!');
                        }
                      }, Color.fromRGBO(57, 57, 57, 25),
                          Color.fromRGBO(57, 57, 57, 25), screenWidth - 30,
                          textColor: Colors.white),
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

  Container buildPasswordField(double screenWidth,
      TextEditingController controller, bool visible, onPressed, validator) {
    return Container(
      width: screenWidth,
      child: TextFormField(
        autocorrect: false,
        // ignore: missing_return
        validator: validator,
        obscureText: !visible,
        controller: controller,

        style: TextStyle(
            color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: 'Tap to enter...',
          hintStyle: TextStyle(
              color: Colors.black38,
              fontSize: 14.0,
              fontWeight: FontWeight.w400),
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
          enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: dividerColor, width: 0.5)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off_outlined,
              color: visible ? Colors.black54 : Colors.black38,
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

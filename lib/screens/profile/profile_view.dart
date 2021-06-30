import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobProviderApp/jobProviderHome.dart';
import 'package:workampus/screens/jobSeekerApp/jobSeekerHome.dart';
import 'package:workampus/screens/profile/profile_viewmodel.dart';
import 'package:workampus/screens/profile/publicProfile_view.dart';
import 'package:workampus/screens/profile/updatePassword_view.dart';
import 'package:workampus/screens/profile/updateProfile_view.dart';
import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';

import '../initialScreen/login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({this.tab});
  final int tab;
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // direct to public profile
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PublicProfileView(model.currentUser),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 67),
                height: 116.5,
                width: screenWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 75,
                          width: 75,
                          color: Colors.blue,
                          child: model.currentUser.photoUrl == ''
                              ? Icon(
                                  FontAwesomeIcons.user,
                                  color: black,
                                )
                              : CachedNetworkImage(
                                  imageUrl: model.currentUser.photoUrl,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.5),
                    Center(
                      child: FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.currentUser.displayName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 21,
                                    color: Colors.black87)),
                            SizedBox(height: 1),
                            Text(
                              model.currentUser.email,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 5),
                            Text(
                              model.currentUser.address,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 18.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: accentColor,
                    ),
                    title: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdatePasswordView(user: model.currentUser),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text("Change Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19,
                                  color: Colors.black87)),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    width: double.infinity,
                    height: 1.0,
                    color: dividerColor,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: accentColor,
                    ),
                    title: InkWell(
                      onTap: () {
                        // Direct to update info
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateProfileView(user: model.currentUser),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text("Edit Information",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19,
                                  color: Colors.black87)),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 12.5, bottom: 12.5),
              child: Text(
                'Account Settings',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 5, bottom: 5),
              child: Column(
                children: [
                  SwitchListTile(
                    dense: true,
                    activeColor: accentColor,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text(
                      "Received Notification",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    dense: true,
                    activeColor: accentColor,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text(
                      "Email Notification",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    dense: true,
                    activeColor: accentColor,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (val) {},
                  ),
                ],
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 12.5, bottom: 12.5),
              child: Text(
                'About',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 12.5, bottom: 12.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Version Alpha 3.0',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600)),
                  Text(
                    'Released 17th January 2020',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  if (model.currentUser.roles == 'Job Provider') {
                    model.currentUser.roles = 'Job Seeker';
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobSeekerHome(tab: 0)));
                    awesomeToast('Switched to Job Seeker!');
                  } else if (model.currentUser.roles == 'Job Seeker') {
                    model.currentUser.roles = 'Job Provider';
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobProviderHome(tab: 0)));
                    awesomeToast('Switched to Job Provider!');
                  }
                },
                child: Text(
                  model.currentUser.roles == 'Job Provider'
                      ? 'Switch to Job Seeker'
                      : 'Switch to Job Provider',
                  style: TextStyle(
                      color: accentColor,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('Profile', style: TextStyle(fontWeight: FontWeight.w500)),
      leading: Row(
        children: <Widget>[
          SizedBox(width: 15.0),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.chevron_left,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.logout, color: themeColor), onPressed: signOut)
      ],
    );
  }

  Future<void> signOut() async {
    try {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
      awesomeToast('Signed Out');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}

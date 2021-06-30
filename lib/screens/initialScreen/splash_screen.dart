import 'package:workampus/app/locator.dart';
import 'package:workampus/app/router.dart';
import 'package:workampus/services/navigation_service.dart';
import 'package:workampus/shared/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final NavigationService _navigationService = locator<NavigationService>();
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    Future.delayed(Duration(seconds: 3), () {
      _navigationService.navigateTo(LoginViewRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/workampusLogo.png',
                // height: 100,
                width: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

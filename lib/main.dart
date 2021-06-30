//import 'package:dulang_new/pages/editProfile.dart';
// import 'package:dulang_new/pages/initialScreen/login.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:workampus/services/dialog_service.dart';
import 'package:workampus/services/navigation_service.dart';
import 'package:workampus/shared/colors.dart';
import 'package:workampus/app/locator.dart';
import 'package:flutter/material.dart';

import 'app/router.dart';
// import 'managers/dialog_manager.dart';
// import 'package:workampus/screens/home.dart';
// import 'package:dulang_new/pages/initialScreen/splash.dart';

// import 'package:dulang_new/pages/initialScreen/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeLocator();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workampus',
      debugShowCheckedModeBanner: false,
      // builder: (context, child) => Navigator(
      //   // key: locator<DialogService>().dialogNavigationKey,
      //   onGenerateRoute: (settings) => MaterialPageRoute(
      //       builder: (context) => DialogManager(child: child)),
      // ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
          fontFamily: 'Poppins',
          accentColor: accentColor,
          primaryColor: primaryColor),
      initialRoute: SplashViewRoute,
      onGenerateRoute: generateRoute,
    );
  }
}

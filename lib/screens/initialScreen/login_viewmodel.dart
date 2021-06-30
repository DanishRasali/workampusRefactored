import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workampus/app/locator.dart';
import 'package:workampus/app/router.dart';
import 'package:workampus/screens/jobProviderApp/jobProviderHome.dart';
import 'package:workampus/screens/jobSeekerApp/jobSeekerHome.dart';
import 'package:workampus/screens/viewmodel.dart';
import 'package:workampus/services/authentication_service.dart';
// import 'package:workampus/services/dialog_service.dart';
import 'package:workampus/services/navigation_service.dart';
import 'package:workampus/shared/toastAndDialog.dart';

class LoginViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  // final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signIn({
    @required String email,
    @required String password,
    @required context,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      print(currentUser.roles);
      if (result) {
        if (currentUser.roles == 'Job Seeker') {
          await Future.delayed(Duration(seconds: 1));
          Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(builder: (context) => JobSeekerHome(tab: 0)));
        } else if (currentUser.roles == 'Job Provider') {
          await Future.delayed(Duration(seconds: 1));
          Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(builder: (context) => JobProviderHome(tab: 0)));
        }
      } else {
        // await _dialogService.showDialog(
        //   title: 'Login Failure',
        //   description: 'General login failure. Please try again later',
        // );
        awesomeSingleDialog(
            context,
            'Login Error',
            'General login failure. Please try again later',
            () => Navigator.of(context, rootNavigator: true).pop());
      }
    } else {
      awesomeSingleDialog(context, 'Login Error', result,
          () => Navigator.of(context, rootNavigator: true).pop());
    }
  }

  void navigateToRegistration() {
    _navigationService.navigateTo(RegisterViewRoute);
  }
}

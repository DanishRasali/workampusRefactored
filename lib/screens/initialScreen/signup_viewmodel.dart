import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workampus/app/locator.dart';
import 'package:workampus/app/router.dart';
import 'package:workampus/screens/viewmodel.dart';
import 'package:workampus/services/authentication_service.dart';
// import 'package:workampus/services/dialog_service.dart';
import 'package:workampus/services/navigation_service.dart';
import 'package:workampus/shared/toastAndDialog.dart';

class SignupViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  // final DialogService _dialogService = locator<DialogService>();

  Future register({
    @required String email,
    @required String displayName,
    @required String address,
    @required String password,
    @required String roles,
    @required context,
  }) async {
    setBusy(true);

    var result = await _authenticationService.registerWithEmailAndPassword(
      email: email,
      displayName: displayName,
      address: address,
      password: password,
      roles: roles,
    );

    setBusy(false);

    if (result is bool) {
      print(currentUser.roles);
      if (result) {
        if (currentUser.roles == 'Job Seeker') {
          _navigationService.navigateReplacementTo(JobSeekerHomeViewRoute);
        } else
          _navigationService.navigateReplacementTo(JobProviderHomeViewRoute);
      } else {
        awesomeSingleDialog(
            context,
            'Registration Error',
            'General registration failure. Please try again later',
            () => Navigator.of(context, rootNavigator: true).pop());
      }
    } else {
      // await _dialogService.showDialog(
      //   title: 'Login Failure',
      //   description: result,
      // );
      awesomeSingleDialog(context, 'Registration Error', result,
          () => Navigator.of(context, rootNavigator: true).pop());
    }
  }
}

import 'package:stacked/stacked.dart';
import 'package:workampus/app/locator.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/services/authentication_service.dart';

class ViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;
}
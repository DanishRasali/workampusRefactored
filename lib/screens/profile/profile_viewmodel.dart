import 'package:flutter/foundation.dart';
import 'package:workampus/app/locator.dart';
import 'package:workampus/models/rating.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/services/authentication_service.dart';
import 'package:workampus/services/rating/rating_firestore_service.dart';
import 'package:workampus/services/user/user_firestore_service.dart';

import 'package:workampus/services/cloud_storage_service.dart';
import 'dart:io';
import '../viewmodel.dart';

class ProfileViewModel extends ViewModel {
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();
  final RatingFirestoreService _ratingFirestoreService =
      locator<RatingFirestoreService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  bool empty = false;
  User user;

  List<Rating> _myRatings;
  List<Rating> get myRatings => _myRatings;

  List<User> _raters;
  List<User> get raters => _raters;

  Future initialise(User user) async {
    List<String> ratersIDs = [];

    setBusy(true);

    _myRatings = await _ratingFirestoreService.getMyRatings(user.id);
    _myRatings.sort((b, a) => a.createdAt.millisecondsSinceEpoch
        .compareTo(b.createdAt.millisecondsSinceEpoch));
    print('rating dapatt ' + _myRatings.length.toString());

    if (_myRatings.length == 0) {
      setBusy(false);
      empty = true;
    } else {
      final temp = _myRatings.map((e) {
        if (!ratersIDs.contains(e.raterID)) return e.raterID;
      }).toList();
      ratersIDs.addAll(temp);

      _raters = await _userFirestoreService.getUsersFromIDs(ratersIDs);
      setBusy(false);
    }
  }

  void getUser(String id) async {
    _userFirestoreService.getUser(id).then((value) async {
      return user = value;
    });
  }

  void updateProfile({
    @required String displayName,
    @required String desc,
    @required String location,
    File imageFile,
  }) async {
    setBusy(true);

    if (imageFile == null) {
      // Update firebase
      User user = new User(
        currentUser.id,
        currentUser.email,
        location,
        displayName,
        desc,
        currentUser.photoUrl,
        currentUser.headerPhotoUrl,
        currentUser.userRating,
        currentUser.ratingCount,
        currentUser.spending,
        currentUser.earning,
        currentUser.roles,
      );

      await _userFirestoreService.updateUser(currentUser.id, user: user);

      // Update currentUser offiline data
      currentUser.displayName = displayName;
      currentUser.desc = desc;
      currentUser.address = location;
    } else {
      await cloudStorageService
          .uploadImage(
        imageToUpload: imageFile,
        title: currentUser.displayName,
        displayName: displayName,
        desc: desc,
        location: location,
      )
          .whenComplete(() {
        print('Process Settelll');
      });
    }

    setBusy(false);
  }

  Future<bool> validateCurrentPassword(String password) async {
    return await _authenticationService.validatePassword(password);
  }

  User getRater(String id) => _raters.firstWhere((rater) => rater.id == id);

  void updatePassword(String password) {
    _authenticationService.updatePassword(password);
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:flutter/cupertino.dart';
import 'package:workampus/models/cloud_storage_result.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/services/user/user_firestore_service.dart';

import 'package:workampus/screens/viewmodel.dart';
import 'package:workampus/app/locator.dart';

class CloudStorageService extends ViewModel {
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();
  static final CloudStorageService _instance =
      CloudStorageService._constructor();

  factory CloudStorageService() {
    return _instance;
  }

  CloudStorageService._constructor();

  Future<CloudStorageResult> uploadImage({
    @required File imageToUpload,
    @required String title,
    String displayName,
    String desc,
    String location,
  }) async {
    var imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();

    // Get the reference to the file we want to create
    final firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('profilePictures/${Path.basename(imageFileName)}');

    firebase_storage.UploadTask task =
        firebaseStorageRef.putFile(imageToUpload);

    String url;
    task.whenComplete(() async {
      print('file uploaded!');
      await firebaseStorageRef.getDownloadURL().then((value) {
        url = value;
      }).whenComplete(() async {
        print('URL DPAT NI');
        print(url);

        // Update profile
        User user = new User(
          currentUser.id,
          currentUser.email,
          location,
          displayName,
          desc,
          url,
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
        currentUser.photoUrl = url;

        return CloudStorageResult(
          imageUrl: url,
          imageFileName: imageFileName,
        );
      });
    });

    return null;
  }

  Future deleteImage(String imageFileName) async {
    final firebase_storage.Reference firebaseStorageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
    } catch (e) {
      return e.toString();
    }
  }
}

final cloudStorageService = CloudStorageService();

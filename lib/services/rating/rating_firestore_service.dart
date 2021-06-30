import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workampus/models/rating.dart';
import 'package:workampus/utils/datetime_timestamp_util.dart';

class RatingFirestoreService {
  final CollectionReference _ratingsRef =
      FirebaseFirestore.instance.collection('ratings');

  Future<Rating> getRating(String id) async {
    DocumentSnapshot snapshot = await _ratingsRef.doc(id).get();
    return Rating.fromSnapshot(snapshot);
  }

  Future<List<Rating>> getRatings() async {
    print('retrieving all ratings data');
    QuerySnapshot snapshots = await _ratingsRef.get();
    return snapshots.docs
        .map((snapshot) => Rating.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<Rating>> getMyRatingForAContract(
      String userID, String contractsID) async {
    print('retrieving my rating for this contract');
    QuerySnapshot snapshots = await _ratingsRef
        .where('raterID', isEqualTo: userID)
        .where('contractsID', isEqualTo: contractsID)
        .get();
    return snapshots.docs
        .map((snapshot) => Rating.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<Rating>> getMyRatings(String uid) async {
    print('retrieving my rating for this contract');
    QuerySnapshot snapshots =
        await _ratingsRef.where('uid', isEqualTo: uid).get();
    return snapshots.docs
        .map((snapshot) => Rating.fromSnapshot(snapshot))
        .toList();
  }

  // get all my services
  Future<List<Rating>> getJobProviderRatings(String currUserID) async {
    print('retrieving my ratings');
    QuerySnapshot snapshots =
        await _ratingsRef.where('currUserID', isEqualTo: currUserID).get();
    return snapshots.docs
        .map((snapshot) => Rating.fromSnapshot(snapshot))
        .toList();
  }

  Future receiveCashRating(String id) async {
    Map<String, dynamic> data = Map();
    ({
      'pending': false,
      'RatingDate': timeNow + ' ' + usDate,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _ratingsRef.doc(id).update(data);
  }

  // Future<List<Rating>> getRatingsFromIDs(
  //     List<String> ids) async {
  //   QuerySnapshot snapshots = await _RatingsRef
  //       .where(FieldPath.documentId, whereIn: ids)
  //       .get();
  //   return snapshots.docs.map((snapshot) {
  //     return Rating.fromSnapshot(snapshot);
  //   }).toList();
  // }

  // Future<List<Rating>> getCompanionFeed(List<String> ids) async {
  //   QuerySnapshot snapshots =
  //       await _RatingsRef.where('authorId', whereIn: ids).get();
  //   return snapshots.docs.map((snapshot) {
  //     return Rating.fromSnapshot(snapshot);
  //   }).toList();
  // }

  // Future<List<Rating>> getCommunityFeed(List<String> ids) async {
  //   QuerySnapshot snapshots =
  //       await _RatingsRef.where('communityId', whereIn: ids).get();
  //   return snapshots.docs.map((snapshot) {
  //     return Rating.fromSnapshot(snapshot);
  //   }).toList();
  // }

  Future createRating(Rating rating) async {
    return _ratingsRef.add(rating.toJson());
  }

  Future updateRatingID(
    String id,
  ) async {
    Map<String, dynamic> data = Map();
    ({
      'id': id,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _ratingsRef.doc(id).update(data);
  }

  Future updateRatingStatus(
    String id, {
    String status,
  }) async {
    Map<String, dynamic> data = Map();
    ({
      'status': status,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _ratingsRef.doc(id).update(data);
  }

  Future deleteRating(String id) async {
    await _ratingsRef.doc(id).delete();
  }
}

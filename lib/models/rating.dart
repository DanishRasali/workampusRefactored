import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workampus/utils/datetime_timestamp_util.dart';

class Rating {
  String id, review, uid, raterID, contractsID;
  double starRating;
  DateTime createdAt;

  Rating(
      {this.id,
      this.review,
      this.uid,
      this.raterID,
      this.contractsID,
      this.starRating,
      this.createdAt});

  factory Rating.createNew({
    String id,
    String review,
    String uid,
    String raterID,
    String contractsID,
    double starRating,
  }) =>
      Rating(
        id: id,
        contractsID: contractsID,
        uid: uid,
        raterID: raterID,
        review: review,
        starRating: starRating,
        createdAt: DateTime.now(),
      );

  factory Rating.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Rating.fromJson(json);
  }

  factory Rating.fromRawJson(String str) => Rating.fromJson(jsonDecode(str));

  Rating.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          contractsID: json['contractsID'],
          uid: json['uid'],
          raterID: json['raterID'],
          review: json['review'],
          starRating: json['starRating'],
          createdAt: dateTimeFromTimestamp(json['createdAt']),
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'contractsID': contractsID,
        'uid': uid,
        'raterID': raterID,
        'review': review,
        'starRating': starRating,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}

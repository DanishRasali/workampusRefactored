import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workampus/utils/datetime_timestamp_util.dart';

class Payout {
  String id, userID;
  double requestAmount;
  bool processed;
  DateTime createdAt;
  String requestedDate;

  Payout({
    this.id,
    this.userID,
    this.requestAmount,
    this.processed,
    this.createdAt,
    this.requestedDate,
  });

  factory Payout.createNew({
    String id,
    String userID,
    double requestAmount,
  }) =>
      Payout(
        id: id,
        userID: userID,
        requestAmount: requestAmount,
        processed: false,
        createdAt: DateTime.now(),
        requestedDate: usDate,
      );

  factory Payout.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Payout.fromJson(json);
  }

  factory Payout.fromRawJson(String str) => Payout.fromJson(jsonDecode(str));

  Payout.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          userID: json['userID'],
          requestAmount: json['requestAmount'],
          processed: json['processed'],
          createdAt: dateTimeFromTimestamp(json['createdAt']),
          requestedDate: json['requestedDate'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userID': userID,
        'requestAmount': requestAmount,
        'processed': processed,
        'createdAt': Timestamp.fromDate(createdAt),
        'requestedDate': requestedDate,
      };
}

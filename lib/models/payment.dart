import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workampus/utils/datetime_timestamp_util.dart';

class Payment {
  String id, contractID, contractorID, currUserID;
  String amount;
  String paymentDate, type;
  bool pending;
  DateTime createdAt;

  Payment({
    this.id,
    this.contractID,
    this.contractorID,
    this.currUserID,
    this.amount,
    this.pending,
    this.paymentDate,
    this.type,
    this.createdAt,
  });

  factory Payment.createNew({
    String id,
    String contractID,
    String contractorID,
    String currUserID,
    String amount,
    String type,
    String paymentDate,
    bool pending,
  }) =>
      Payment(
        id: id,
        contractID: contractID,
        contractorID: contractorID,
        currUserID: currUserID,
        amount: amount,
        pending: pending,
        type: type,
        paymentDate: paymentDate,
        createdAt: DateTime.now(),
      );

  factory Payment.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Payment.fromJson(json);
  }

  factory Payment.fromRawJson(String str) => Payment.fromJson(jsonDecode(str));

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'],
        contractID: json['contractID'],
        contractorID: json['contractorID'],
        currUserID: json['currUserID'],
        amount: json['amount'],
        pending: json['pending'],
        type: json['type'],
        paymentDate: json['paymentDate'],
        createdAt: dateTimeFromTimestamp(json['createdAt']),
      );

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'contractID': contractID,
        'contractorID': contractorID,
        'currUserID': currUserID,
        'amount': amount,
        'pending': pending,
        'type': type,
        'paymentDate': paymentDate,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}

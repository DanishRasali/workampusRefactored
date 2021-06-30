import 'dart:convert';
import 'package:workampus/utils/datetime_timestamp_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Contract {
  String id,
      currUserID,
      contractorID,
      title,
      desc,
      category,
      type,
      rate,
      contractMessage,
      status,
      dueDate;
  bool pendingComplete;
  bool pendingPayment;
  bool isReviewedByJS;
  bool isReviewedByJP;
  DateTime createdAt;

  Contract({
    this.id,
    this.currUserID,
    this.contractorID,
    this.title,
    this.desc,
    this.category,
    this.type,
    this.rate,
    this.contractMessage,
    this.status,
    this.dueDate,
    this.pendingComplete,
    this.pendingPayment,
    this.isReviewedByJS,
    this.isReviewedByJP,
    this.createdAt,
  });

  factory Contract.createNew({
    String id,
    currUserID,
    contractorID,
    title,
    desc,
    category,
    type,
    rate,
    contractMessage,
    dueDate,
  }) =>
      Contract(
        id: id,
        currUserID: currUserID,
        contractorID: contractorID,
        title: title,
        desc: desc,
        category: category,
        type: type,
        rate: rate,
        contractMessage: contractMessage,
        dueDate: dueDate,
        status: 'pending',
        pendingComplete: false,
        pendingPayment: false,
        isReviewedByJS: false,
        isReviewedByJP: false,
        createdAt: DateTime.now(),
      );

  factory Contract.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Contract.fromJson(json);
  }

  factory Contract.fromRawJson(String str) =>
      Contract.fromJson(jsonDecode(str));

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        id: json['id'],
        currUserID: json['currUserID'],
        contractorID: json['contractorID'],
        title: json['title'],
        desc: json['desc'],
        category: json['category'],
        type: json['type'],
        rate: json['rate'],
        contractMessage: json['contractMessage'],
        dueDate: json['dueDate'],
        status: json['status'],
        pendingComplete: json['pendingComplete'],
        pendingPayment: json['pendingPayment'],
        isReviewedByJS: json['isReviewedByJS'],
        isReviewedByJP: json['isReviewedByJP'],
        createdAt: dateTimeFromTimestamp(json['createdAt']),
      );

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'currUserID': currUserID,
        'contractorID': contractorID,
        'title': title,
        'desc': desc,
        'category': category,
        'type': type,
        'rate': rate,
        'contractMessage': contractMessage,
        'dueDate': dueDate,
        'status': status,
        'pendingComplete': pendingComplete,
        'pendingPayment': pendingPayment,
        'isReviewedByJS': isReviewedByJS,
        'isReviewedByJP': isReviewedByJP,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}

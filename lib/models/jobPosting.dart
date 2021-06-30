import 'package:workampus/utils/datetime_timestamp_util.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobPosting {
  String id, userID, title, desc, jobDate, status;
  String category;
  String type;
  String rate;
  String createdDate;

  JobPosting(
      {this.id,
      this.userID,
      this.title,
      this.desc,
      this.category,
      this.type,
      this.jobDate,
      this.rate,
      this.status,
      this.createdDate});

  factory JobPosting.createNew({
    String id,
    String userID,
    String title,
    String desc,
    String category,
    String type,
    String jobDate,
    String rate,
  }) =>
      JobPosting(
        id: id,
        userID: userID,
        title: title,
        desc: desc,
        category: category,
        type: type,
        jobDate: jobDate,
        rate: rate,
        status: 'Open',
        createdDate: formattedDate,
      );

  factory JobPosting.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return JobPosting.fromJson(json);
  }

  factory JobPosting.fromRawJson(String str) =>
      JobPosting.fromJson(jsonDecode(str));

  factory JobPosting.fromJson(Map<String, dynamic> json) => JobPosting(
        id: json['id'],
        userID: json['userID'],
        title: json['title'],
        desc: json['desc'],
        category: json['category'],
        type: json['type'],
        jobDate: json['jobDate'],
        rate: json['rate'],
        status: json['status'],
        createdDate: json['createdDate'],
      );

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'userID': userID,
        'title': title,
        'desc': desc,
        'category': category,
        'type': type,
        'jobDate': jobDate,
        'rate': rate,
        'status': status,
        'createdDate': createdDate
      };
}

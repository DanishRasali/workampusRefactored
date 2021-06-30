import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


DateTime now = DateTime.now();
String formattedDate = DateFormat('dd-MM-yyyy').format(now);

class OfferedService {
  String id, userID, title, desc, availability, status;
  String category;
  String type;
  String charges;
  String createdDate;

  OfferedService(
      {this.id,
      this.userID,
      this.title,
      this.desc,
      this.category,
      this.type,
      this.availability,
      this.charges,
      this.status,
      this.createdDate});

  factory OfferedService.createNew({
    String id,
    String userID,
    String title,
    String desc,
    String category,
    String type,
    String availability,
    String charges,
  }) =>
      OfferedService(
          id: id,
          userID: userID,
          title: title,
          desc: desc,
          category: category,
          type: type,
          availability: availability,
          charges: charges,
          status: 'Ready for hiring',
          createdDate: formattedDate);

  factory OfferedService.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return OfferedService.fromJson(json);
  }

  factory OfferedService.fromRawJson(String str) =>
      OfferedService.fromJson(jsonDecode(str));

  factory OfferedService.fromJson(Map<String, dynamic> json) => OfferedService(
      id: json['id'],
      userID: json['userID'],
      title: json['title'],
      desc: json['desc'],
      category: json['category'],
      type: json['type'],
      availability: json['availability'],
      charges: json['charges'],
      status: json['status'],
      createdDate: json['createdDate']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'userID': userID,
        'title': title,
        'desc': desc,
        'category': category,
        'type': type,
        'availability': availability,
        'charges': charges,
        'status': status,
        'createdDate': createdDate
      };
}
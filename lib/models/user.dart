import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String _id,
      _email,
      _address,
      _displayName,
      _desc,
      _photoUrl,
      _headerPhotoUrl,
      _roles;
  num _userRating;
  num _ratingCount;
  num _spending;
  num _earning;

  User([
    this._id,
    this._email,
    this._address,
    this._displayName,
    this._desc,
    this._photoUrl,
    this._headerPhotoUrl,
    this._userRating,
    this._ratingCount,
    this._spending,
    this._earning,
    this._roles,
  ]);

  String get id => _id;
  void set id(String value) => _id = value;
  String get email => _email;
  void set email(String value) => _email = value;
  String get address => _address;
  void set address(String value) => _address = value;
  String get displayName => _displayName;
  void set displayName(String value) => _displayName = value;
  String get desc => _desc;
  void set desc(String value) => _desc = value;
  String get photoUrl => _photoUrl;
  void set photoUrl(String value) => _photoUrl = value;
  String get headerPhotoUrl => _headerPhotoUrl;
  void set headerPhotoUrl(String value) => _headerPhotoUrl = value;
  String get roles => _roles;
  void set roles(String value) => _roles = value;
  num get userRating => _userRating;
  void set userRating(num value) => _userRating = value;
  num get ratingCount => _ratingCount;
  void set ratingCount(num value) => _ratingCount = value;
  num get spending => _spending;
  void set spending(num value) => _spending = value;
  num get earning => _earning;
  void set earning(num value) => _earning = value;

  factory User.createNew(
          [String _id,
          String _email,
          String _displayName,
          String _address,
          String _roles]) =>
      User(
        _id,
        _email,
        _displayName,
        '',
        _address,
        '',
        '',
        0.1,
        0,
        0,
        0,
        _roles,
      );

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return User.fromJson(json);
  }

  factory User.fromRawJson(String str) => User.fromJson(jsonDecode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['id'],
        json['email'],
        json['address'],
        json['displayName'],
        json['desc'],
        json['photoUrl'],
        json['headerPhotoUrl'],
        json['userRating'],
        json['ratingCount'],
        json['spending'],
        json['earning'],
        json['roles'],
      );

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'id': _id,
        'email': _email,
        'address': _address,
        'displayName': _displayName,
        'desc': _desc,
        'photoUrl': _photoUrl,
        'headerPhotoUrl': _headerPhotoUrl,
        'userRating': _userRating,
        'ratingCount': _ratingCount,
        'roles': _roles,
        'spending': _spending,
        'earning': _earning,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user.dart';

class UserFirestoreService {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _usersRef.doc(id).get();
    return User.fromSnapshot(snapshot);
  }

  Future<List<User>> getUsers() async {
    QuerySnapshot snapshots = await _usersRef.get();
    return snapshots.docs
        .map((snapshot) => User.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<User>> getUsersFromIDs(List<String> ids) async {
    QuerySnapshot snapshots =
        await _usersRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs.map((snapshot) {
      return User.fromSnapshot(snapshot);
    }).toList();
  }

  Future createUser(User user) async {
    return _usersRef.doc(user.id).set(user.toJson());
  }

  Future updateUser(String id, {User user}) async {
    Map<String, dynamic> data = Map();
    ({
      'email': user.email,
      'address': user.address,
      'displayName': user.displayName,
      'desc': user.desc,
      'photoUrl': user.photoUrl,
      'headerPhotoUrl': user.headerPhotoUrl,
      'userRating': user.userRating,
      'ratingCount': user.ratingCount,
      'roles': user.roles,
      'spending': user.spending,
      'earning': user.earning,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _usersRef.doc(id).update(data);
  }

  Future deleteUser(String id) async {
    await _usersRef.doc(id).delete();
  }
}

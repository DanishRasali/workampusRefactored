import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workampus/models/offeredService.dart';

class OfferedServiceFirestoreService {
  final CollectionReference _offeredServicesRef =
      FirebaseFirestore.instance.collection('offeredServices');

  Future<OfferedService> getOfferedService(String id) async {
    DocumentSnapshot snapshot = await _offeredServicesRef.doc(id).get();
    return OfferedService.fromSnapshot(snapshot);
  }

  Future<List<OfferedService>> getOfferedServices() async {
    print('retrieving data');
    QuerySnapshot snapshots = await _offeredServicesRef.get();
    return snapshots.docs
        .map((snapshot) => OfferedService.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<OfferedService>> getOfferedServicesFromIDs(List<String> ids) async {
    QuerySnapshot snapshots =
        await _offeredServicesRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs.map((snapshot) {
      return OfferedService.fromSnapshot(snapshot);
    }).toList();
  }

  // get all my services
  Future<List<OfferedService>> getMyServices(String userID) async {
    print('retrieving my offered services');
    QuerySnapshot snapshots = await _offeredServicesRef.where('userID', isEqualTo: userID).get();
    return snapshots.docs
        .map((snapshot) => OfferedService.fromSnapshot(snapshot))
        .toList();
  }

  Future createOfferedService(OfferedService offeredService) async {
    return _offeredServicesRef.add(offeredService.toJson());
  }

  Future updateOfferedServiceID(
    String id,
  ) async {
    Map<String, dynamic> data = Map();
    ({
      'id': id,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _offeredServicesRef.doc(id).update(data);
  }

  Future updateOfferedService(
    String id, {
    String title,
    String desc,
    String category,
    String type,
    String availability,
    String charges,
  }) async {
    Map<String, dynamic> data = Map();
    ({
      'title': title,
      'desc': desc,
      'category': category,
      'type': type,
      'availability': availability,
      'charges': charges,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _offeredServicesRef.doc(id).update(data);
  }

  Future deleteOfferedService(String id) async {
    await _offeredServicesRef.doc(id).delete();
  }

    // get by type
  Future<List<OfferedService>> getOfferedServicesByType(String type) async {
    print('retrieving offered services by types');
    QuerySnapshot snapshots =
        await _offeredServicesRef.where('type', isEqualTo: type).get();
    return snapshots.docs
        .map((snapshot) => OfferedService.fromSnapshot(snapshot))
        .toList();
  }
}

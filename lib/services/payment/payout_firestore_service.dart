import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workampus/models/payout.dart';



class PayoutFirestoreService {
  final CollectionReference _payoutsRef =
      FirebaseFirestore.instance.collection('payouts');

  // Future<Payout> getPayout(String id) async {
  //   DocumentSnapshot snapshot = await _payoutsRef.doc(id).get();
  //   return Payout.fromSnapshot(snapshot);
  // }

  // Future<List<Payout>> getPayouts() async {
  //   print('retrieving all Payouts data');
  //   QuerySnapshot snapshots = await _payoutsRef.get();
  //   return snapshots.docs
  //       .map((snapshot) => Payout.fromSnapshot(snapshot))
  //       .toList();
  // }

  // get all my services
  // Future<List<Payout>> getJobSeekerPayouts(String contractorID) async {
  //   print('retrieving my Payouts');
  //   QuerySnapshot snapshots =
  //       await _PayoutsRef.where('contractorID', isEqualTo: contractorID).get();
  //   return snapshots.docs
  //       .map((snapshot) => Payout.fromSnapshot(snapshot))
  //       .toList();
  // }

  // Future<List<Payout>> getJobProviderPayouts(String currUserID) async {
  //   print('retrieving my Payouts');
  //   QuerySnapshot snapshots =
  //       await _PayoutsRef.where('currUserID', isEqualTo: currUserID).get();
  //   return snapshots.docs
  //       .map((snapshot) => Payout.fromSnapshot(snapshot))
  //       .toList();
  // }

  // Future receiveCashPayout(String id) async {
  //   Map<String, dynamic> data = Map();
  //   ({
  //     'pending': false,
  //     'PayoutDate': timeNow + ' ' + usDate,
  //   }).forEach((key, value) {
  //     if (value != null) data[key] = value;
  //   });

  //   return _PayoutsRef.doc(id).update(data);
  // }

  // Future<List<Payout>> getPayoutsFromIDs(
  //     List<String> ids) async {
  //   QuerySnapshot snapshots = await _PayoutsRef
  //       .where(FieldPath.documentId, whereIn: ids)
  //       .get();
  //   return snapshots.docs.map((snapshot) {
  //     return Payout.fromSnapshot(snapshot);
  //   }).toList();
  // }

  // Future<List<Payout>> getCompanionFeed(List<String> ids) async {
  //   QuerySnapshot snapshots =
  //       await _PayoutsRef.where('authorId', whereIn: ids).get();
  //   return snapshots.docs.map((snapshot) {
  //     return Payout.fromSnapshot(snapshot);
  //   }).toList();
  // }

  // Future<List<Payout>> getCommunityFeed(List<String> ids) async {
  //   QuerySnapshot snapshots =
  //       await _PayoutsRef.where('communityId', whereIn: ids).get();
  //   return snapshots.docs.map((snapshot) {
  //     return Payout.fromSnapshot(snapshot);
  //   }).toList();
  // }

  Future createPayout(Payout payout) async {
    return _payoutsRef.add(payout.toJson());
  }

  Future updatePayoutID(
    String id,
  ) async {
    Map<String, dynamic> data = Map();
    ({
      'id': id,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _payoutsRef.doc(id).update(data);
  }

  // Future updatePayoutStatus(
  //   String id, {
  //   String status,
  // }) async {
  //   Map<String, dynamic> data = Map();
  //   ({
  //     'status': status,
  //   }).forEach((key, value) {
  //     if (value != null) data[key] = value;
  //   });

  //   return _payoutsRef.doc(id).update(data);
  // }

  Future deletePayout(String id) async {
    await _payoutsRef.doc(id).delete();
  }
}

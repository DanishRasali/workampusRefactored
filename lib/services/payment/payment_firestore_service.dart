import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workampus/models/payment.dart';
import 'package:workampus/utils/datetime_timestamp_util.dart';



class PaymentFirestoreService {
  final CollectionReference _paymentsRef =
      FirebaseFirestore.instance.collection('payments');

  Future<Payment> getPayment(String id) async {
    DocumentSnapshot snapshot = await _paymentsRef.doc(id).get();
    return Payment.fromSnapshot(snapshot);
  }

  Future<List<Payment>> getPayments() async {
    print('retrieving all payments data');
    QuerySnapshot snapshots = await _paymentsRef.get();
    return snapshots.docs
        .map((snapshot) => Payment.fromSnapshot(snapshot))
        .toList();
  }

  // get all my services
  Future<List<Payment>> getJobSeekerPayments(String contractorID) async {
    print('retrieving my payments');
    QuerySnapshot snapshots =
        await _paymentsRef.where('contractorID', isEqualTo: contractorID).get();
    return snapshots.docs
        .map((snapshot) => Payment.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<Payment>> getJobProviderPayments(String currUserID) async {
    print('retrieving my payments');
    QuerySnapshot snapshots =
        await _paymentsRef.where('currUserID', isEqualTo: currUserID).get();
    return snapshots.docs
        .map((snapshot) => Payment.fromSnapshot(snapshot))
        .toList();
  }

  Future receiveCashPayment(String id) async {
    Map<String, dynamic> data = Map();
    ({
      'pending': false,
      'paymentDate': timeNow + ' ' + usDate,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _paymentsRef.doc(id).update(data);
  }

  // Future<List<payment>> getPaymentsFromIDs(
  //     List<String> ids) async {
  //   QuerySnapshot snapshots = await _paymentsRef
  //       .where(FieldPath.documentId, whereIn: ids)
  //       .get();
  //   return snapshots.docs.map((snapshot) {
  //     return payment.fromSnapshot(snapshot);
  //   }).toList();
  // }

  // Future<List<payment>> getCompanionFeed(List<String> ids) async {
  //   QuerySnapshot snapshots =
  //       await _paymentsRef.where('authorId', whereIn: ids).get();
  //   return snapshots.docs.map((snapshot) {
  //     return payment.fromSnapshot(snapshot);
  //   }).toList();
  // }

  // Future<List<payment>> getCommunityFeed(List<String> ids) async {
  //   QuerySnapshot snapshots =
  //       await _paymentsRef.where('communityId', whereIn: ids).get();
  //   return snapshots.docs.map((snapshot) {
  //     return payment.fromSnapshot(snapshot);
  //   }).toList();
  // }

  Future createPayment(Payment payment) async {
    return _paymentsRef.add(payment.toJson());
  }

  Future updatePaymentID(
    String id,
  ) async {
    Map<String, dynamic> data = Map();
    ({
      'id': id,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _paymentsRef.doc(id).update(data);
  }

  Future updatePaymentStatus(
    String id, {
    String status,
  }) async {
    Map<String, dynamic> data = Map();
    ({
      'status': status,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _paymentsRef.doc(id).update(data);
  }

  Future deletePayment(String id) async {
    await _paymentsRef.doc(id).delete();
  }
}

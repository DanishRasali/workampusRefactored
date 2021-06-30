import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workampus/models/contract.dart';

class ContractFirestoreService {
  final CollectionReference _contractsRef =
      FirebaseFirestore.instance.collection('contracts');

  Future<Contract> getContract(String id) async {
    DocumentSnapshot snapshot = await _contractsRef.doc(id).get();
    return Contract.fromSnapshot(snapshot);
  }

  Future<List<Contract>> getContracts() async {
    print('retrieving all contracts data');
    QuerySnapshot snapshots = await _contractsRef.get();
    return snapshots.docs
        .map((snapshot) => Contract.fromSnapshot(snapshot))
        .toList();
  }

  // get all my services
  Future<List<Contract>> getMyContractsByStatus1Step(
      String userID, String status) async {
    print('retrieving my contracts');
    QuerySnapshot snapshots = await _contractsRef
        .where('currUserID', isEqualTo: userID)
        .where('status', isEqualTo: status)
        .get();
    return snapshots.docs
        .map((snapshot) => Contract.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<Contract>> getMyContractsByStatus2Step(
      String userID, String status) async {
    print('retrieving my contracts');
    QuerySnapshot snapshots = await _contractsRef
        .where('contractorID', isEqualTo: userID)
        .where('status', isEqualTo: status)
        .get();
    return snapshots.docs
        .map((snapshot) => Contract.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<Contract>> getMyContracts(String userID) async {
    print('retrieving my contracts');
    QuerySnapshot snapshots =
        await _contractsRef.where('currUserID', isEqualTo: userID).get();
    return snapshots.docs
        .map((snapshot) => Contract.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<Contract>> getContractsFromIDs(List<String> ids) async {
    QuerySnapshot snapshots =
        await _contractsRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs.map((snapshot) {
      return Contract.fromSnapshot(snapshot);
    }).toList();
  }

  Future<List<Contract>> getMyServiceRequests(String userID) async {
    print('retrieving my service requests');
    QuerySnapshot snapshots = await _contractsRef
        .where('contractorID', isEqualTo: userID)
        .where('status', isEqualTo: 'pending')
        .get();
    return snapshots.docs
        .map((snapshot) => Contract.fromSnapshot(snapshot))
        .toList();
  }

  Future createContract(Contract contract) async {
    return _contractsRef.add(contract.toJson());
  }

  Future updateContractID(
    String id,
  ) async {
    Map<String, dynamic> data = Map();
    ({
      'id': id,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _contractsRef.doc(id).update(data);
  }

  Future updateContractStatus(
    String id, {
    String status,
  }) async {
    Map<String, dynamic> data = Map();
    ({
      'status': status,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _contractsRef.doc(id).update(data);
  }

  Future updateContractPending(
    String id, {
    bool pendingComplete,
  }) async {
    Map<String, dynamic> data = Map();
    ({
      'pendingComplete': pendingComplete,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _contractsRef.doc(id).update(data);
  }

  Future updateContractPayment(
    String id, {
    bool pendingPayment,
  }) async {
    Map<String, dynamic> data = Map();
    ({
      'pendingPayment': pendingPayment,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _contractsRef.doc(id).update(data);
  }

  Future updateContractIsReviewed(
    String id, {
    bool isReviewedByJS,
    bool isReviewedByJP,
  }) async {
    Map<String, dynamic> data = Map();
    ({
      'isReviewedByJS': isReviewedByJS,
      'isReviewedByJP': isReviewedByJP,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _contractsRef.doc(id).update(data);
  }

  Future deleteContract(String id) async {
    await _contractsRef.doc(id).delete();
  }
}

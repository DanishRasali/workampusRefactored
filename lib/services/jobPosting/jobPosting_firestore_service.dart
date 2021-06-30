import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workampus/models/jobPosting.dart';

class JobPostingFirestoreService {
  final CollectionReference _jobPostingsRef =
      FirebaseFirestore.instance.collection('jobPostings');

  Future<JobPosting> getJobPosting(String id) async {
    DocumentSnapshot snapshot = await _jobPostingsRef.doc(id).get();
    return JobPosting.fromSnapshot(snapshot);
  }

  Future<List<JobPosting>> getJobPostings() async {
    print('retrieving job posting data');
    QuerySnapshot snapshots = await _jobPostingsRef.get();
    return snapshots.docs
        .map((snapshot) => JobPosting.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<JobPosting>> getJobPostingsFromIDs(List<String> ids) async {
    QuerySnapshot snapshots =
        await _jobPostingsRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs.map((snapshot) {
      return JobPosting.fromSnapshot(snapshot);
    }).toList();
  }

  Future<List<JobPosting>> getMyJobPostings(String userID) async {
    print('retrieving my offered services');
    QuerySnapshot snapshots =
        await _jobPostingsRef.where('userID', isEqualTo: userID).get();
    return snapshots.docs
        .map((snapshot) => JobPosting.fromSnapshot(snapshot))
        .toList();
  }

  Future createJobPosting(JobPosting jobPosting) async {
    return _jobPostingsRef.add(jobPosting.toJson());
  }

  Future updateJobPostingID(
    String id,
  ) async {
    Map<String, dynamic> data = Map();
    ({
      'id': id,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _jobPostingsRef.doc(id).update(data);
  }

  Future updateJobPosting(
    String id, {
    String title,
    String desc,
    String category,
    String type,
    String jobDate,
    String rate,
  }) async {
    Map<String, dynamic> data = Map();
    ({
      'title': title,
      'desc': desc,
      'category': category,
      'type': type,
      'jobDate': jobDate,
      'rate': rate,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _jobPostingsRef.doc(id).update(data);
  }

  Future deletejobPosting(String id) async {
    await _jobPostingsRef.doc(id).delete();
  }

  // get by type
  Future<List<JobPosting>> getJobPostingsByType(String type) async {
    print('retrieving job postings by types');
    QuerySnapshot snapshots =
        await _jobPostingsRef.where('type', isEqualTo: type).get();
    return snapshots.docs
        .map((snapshot) => JobPosting.fromSnapshot(snapshot))
        .toList();
  }
}

import 'package:flutter/foundation.dart';
import 'package:workampus/app/locator.dart';
import 'package:workampus/models/jobPosting.dart';
import 'package:workampus/services/jobPosting/jobPosting_firestore_service.dart';

import '../../viewmodel.dart';

class MyJobViewModel extends ViewModel {
  final JobPostingFirestoreService _jobPostingFirestoreService =
      locator<JobPostingFirestoreService>();

  bool empty = false;

  List<JobPosting> _jobPostings;
  List<JobPosting> get jobPostings => _jobPostings;

  Future initialise() async {
    setBusy(true);
    _jobPostings =
        await _jobPostingFirestoreService.getMyJobPostings(currentUser.id);
    if (_jobPostings.length == 0) {
      setBusy(false);
      empty = true;
    } else {
      setBusy(false);
    }
  }

  // Create Service
  void createJob(
      {@required String title,
      @required String desc,
      @required String category,
      @required String type,
      @required String rate,
      @required String jobDate}) async {
    setBusy(true);
    final user = currentUser;
    final jobPosting = JobPosting.createNew(
        userID: user.id,
        title: title,
        desc: desc,
        category: category,
        type: type,
        jobDate: jobDate,
        rate: rate);

    final result =
        await _jobPostingFirestoreService.createJobPosting(jobPosting);

    _jobPostingFirestoreService.updateJobPostingID(result.id);

    setBusy(false);
  }

  //// Read Service

  //// Update Service
  void updateJob({
    @required String id,
    @required String title,
    @required String desc,
    @required String category,
    @required String type,
    @required String rate,
    @required String jobDate,
  }) async {
    setBusy(true);

    await _jobPostingFirestoreService.updateJobPosting(
      id,
      title: title,
      desc: desc,
      category: category,
      type: type,
      rate: rate,
      jobDate: jobDate,
    );

    setBusy(false);
  }

  // Delete Service
  void deleteService({
    @required String id,
  }) async {
    setBusy(true);

    _jobPostingFirestoreService.deletejobPosting(id);

    setBusy(false);
  }
}

import 'package:workampus/models/jobPosting.dart';
import 'package:workampus/services/jobPosting/jobPosting_firestore_service.dart';
import '../../../app/locator.dart';
import '../../../services/user/user_firestore_service.dart';
import '../../../models/user.dart';
import '../../viewmodel.dart';

class JobViewModel extends ViewModel {
  final JobPostingFirestoreService _jobPostingFirestoreService =
      locator<JobPostingFirestoreService>();
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();

  bool empty = false;

  List<User> _jobProviders;
  List<User> get jobProviders => _jobProviders;

  // jobPostings for university Type
  List<JobPosting> _ut1JobPostings;
  List<JobPosting> _ut2JobPostings;
  List<JobPosting> _ut3JobPostings;

  // jobPostings for chores Type
  List<JobPosting> _ct1JobPostings;
  List<JobPosting> _ct2JobPostings;
  List<JobPosting> _ct3JobPostings;

  // jobPostings for errands Type
  List<JobPosting> _et1JobPostings;
  List<JobPosting> _et2JobPostings;

  List<JobPosting> _totalJobPostings;
  List<JobPosting> get totalJobPostings => _totalJobPostings;

  Future initialise({
    bool ut1,
    bool ut2,
    bool ut3,
    bool ct1,
    bool ct2,
    bool ct3,
    bool et1,
    bool et2,
  }) async {
    List<String> users = [];

    // retrieve job postings
    setBusy(true);

    if (ut1 == null &&
        ut2 == null &&
        ut3 == null &&
        ct1 == null &&
        ct2 == null &&
        ct3 == null &&
        et1 == null &&
        et2 == null) {
      ut1 = true;
      ut2 = true;
      ut3 = true;
      ct1 = true;
      ct2 = true;
      ct3 = true;
      et1 = true;
      et2 = true;
    }

    // initialize empty list
    _totalJobPostings =
        await _jobPostingFirestoreService.getJobPostingsByType('null');

    // retrieve job postings for uni types
    if (ut1) {
      _ut1JobPostings = await _jobPostingFirestoreService
          .getJobPostingsByType('Documentation and Editing');

      print('uniType 1 dapat = ' + _ut1JobPostings.length.toString());
      _totalJobPostings.addAll(_ut1JobPostings);
      print('total dapat = ' + _totalJobPostings.length.toString());
    }
    if (ut2) {
      _ut2JobPostings =
          await _jobPostingFirestoreService.getJobPostingsByType('Tutoring');
      print('uniType 2 dapat = ' + _ut2JobPostings.length.toString());
      _totalJobPostings.addAll(_ut2JobPostings);
      print('total dapat = ' + _totalJobPostings.length.toString());
    }
    if (ut3) {
      _ut3JobPostings =
          await _jobPostingFirestoreService.getJobPostingsByType('Assiting');
      print('uniType 3 dapat = ' + _ut3JobPostings.length.toString());
      _totalJobPostings.addAll(_ut3JobPostings);
      print('total dapat = ' + _totalJobPostings.length.toString());
    }

    // retrieve job postings for chores types
    if (ct1) {
      _ct1JobPostings =
          await _jobPostingFirestoreService.getJobPostingsByType('Cleaning');
      print('chorType 1 dapat = ' + _ct1JobPostings.length.toString());
      _totalJobPostings.addAll(_ct1JobPostings);
      print('total dapat = ' + _totalJobPostings.length.toString());
    }
    if (ct2) {
      _ct2JobPostings =
          await _jobPostingFirestoreService.getJobPostingsByType('Laundry');
      print('chorType 2 dapat = ' + _ct2JobPostings.length.toString());
      _totalJobPostings.addAll(_ct2JobPostings);
      print('total dapat = ' + _totalJobPostings.length.toString());
    }
    if (ct3) {
      _ct3JobPostings = await _jobPostingFirestoreService
          .getJobPostingsByType('General Helper');
      print('chorType 3 dapat = ' + _ct3JobPostings.length.toString());
      _totalJobPostings.addAll(_ct3JobPostings);
      print('total dapat = ' + _totalJobPostings.length.toString());
    }

    // retrieve job postings for errands types
    if (et1) {
      _et1JobPostings = await _jobPostingFirestoreService
          .getJobPostingsByType('Delivery/Pickup');
      print('errType 1 dapat = ' + _et1JobPostings.length.toString());
      _totalJobPostings.addAll(_et1JobPostings);
      print('total dapat = ' + _totalJobPostings.length.toString());
    }
    if (et2) {
      _et2JobPostings =
          await _jobPostingFirestoreService.getJobPostingsByType('Shopping');
      print('errType 2 dapat = ' + _et2JobPostings.length.toString());
      _totalJobPostings.addAll(_et2JobPostings);
      print('total dapat = ' + _totalJobPostings.length.toString());
    }

    // finalize all data
    if (_totalJobPostings.length == 0) {
      setBusy(false);
      empty = true;
    } else {
      final temp = _totalJobPostings.map((jobPosting) {
        if (!users.contains(jobPosting.userID)) return jobPosting.userID;
      }).toList();
      users.addAll(temp);
      _jobProviders =
          await _userFirestoreService.getUsersFromIDs(users).then((val) async {
        return _jobProviders = val;
      }).whenComplete(() {
        setBusy(false);
      });
    }
  }

  User getJobProvider(String id) =>
      _jobProviders.firstWhere((jobProvider) => jobProvider.id == id);
}

import 'package:workampus/models/offeredService.dart';
import 'package:workampus/services/offeredService/offeredService_firestore_service.dart';

import '../../../app/locator.dart';

import '../../../services/user/user_firestore_service.dart';

import '../../../models/user.dart';
import '../../viewmodel.dart';

class ServiceViewModel extends ViewModel {
  final OfferedServiceFirestoreService _offeredServiceFirestoreService =
      locator<OfferedServiceFirestoreService>();
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();

  bool empty = false;

  List<User> _jobSeekers;
  List<User> get jobSeekers => _jobSeekers;

  // jobPostings for university Type
  List<OfferedService> _ut1OfferedServices;
  List<OfferedService> _ut2OfferedServices;
  List<OfferedService> _ut3OfferedServices;

  // OfferedServices for chores Type
  List<OfferedService> _ct1OfferedServices;
  List<OfferedService> _ct2OfferedServices;
  List<OfferedService> _ct3OfferedServices;

  // OfferedServices for errands Type
  List<OfferedService> _et1OfferedServices;
  List<OfferedService> _et2OfferedServices;

  List<OfferedService> _totalOfferedServices;
  List<OfferedService> get totalOfferedServices => _totalOfferedServices;

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
    List<String> jobSeekersIDs = [];

    // retrieve all job postings
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
    _totalOfferedServices =
        await _offeredServiceFirestoreService.getOfferedServicesByType('null');

    // retrieve job postings for uni types
    if (ut1) {
      _ut1OfferedServices = await _offeredServiceFirestoreService
          .getOfferedServicesByType('Documentation and Editing');

      print('uniType 1 dapat = ' + _ut1OfferedServices.length.toString());
      _totalOfferedServices.addAll(_ut1OfferedServices);
      print('total dapat = ' + _totalOfferedServices.length.toString());
    }
    if (ut2) {
      _ut2OfferedServices = await _offeredServiceFirestoreService
          .getOfferedServicesByType('Tutoring');
      print('uniType 2 dapat = ' + _ut2OfferedServices.length.toString());
      _totalOfferedServices.addAll(_ut2OfferedServices);
      print('total dapat = ' + _totalOfferedServices.length.toString());
    }
    if (ut3) {
      _ut3OfferedServices = await _offeredServiceFirestoreService
          .getOfferedServicesByType('Assiting');
      print('uniType 3 dapat = ' + _ut3OfferedServices.length.toString());
      _totalOfferedServices.addAll(_ut3OfferedServices);
      print('total dapat = ' + _totalOfferedServices.length.toString());
    }

    // retrieve job postings for chores types
    if (ct1) {
      _ct1OfferedServices = await _offeredServiceFirestoreService
          .getOfferedServicesByType('Cleaning');
      print('chorType 1 dapat = ' + _ct1OfferedServices.length.toString());
      _totalOfferedServices.addAll(_ct1OfferedServices);
      print('total dapat = ' + _totalOfferedServices.length.toString());
    }
    if (ct2) {
      _ct2OfferedServices = await _offeredServiceFirestoreService
          .getOfferedServicesByType('Laundry');
      print('chorType 2 dapat = ' + _ct2OfferedServices.length.toString());
      _totalOfferedServices.addAll(_ct2OfferedServices);
      print('total dapat = ' + _totalOfferedServices.length.toString());
    }
    if (ct3) {
      _ct3OfferedServices = await _offeredServiceFirestoreService
          .getOfferedServicesByType('General Helper');
      print('chorType 3 dapat = ' + _ct3OfferedServices.length.toString());
      _totalOfferedServices.addAll(_ct3OfferedServices);
      print('total dapat = ' + _totalOfferedServices.length.toString());
    }

    // retrieve job postings for errands types
    if (et1) {
      _et1OfferedServices = await _offeredServiceFirestoreService
          .getOfferedServicesByType('Delivery/Pickup');
      print('errType 1 dapat = ' + _et1OfferedServices.length.toString());
      _totalOfferedServices.addAll(_et1OfferedServices);
      print('total dapat = ' + _totalOfferedServices.length.toString());
    }
    if (et2) {
      _et2OfferedServices = await _offeredServiceFirestoreService
          .getOfferedServicesByType('Shopping');
      print('errType 2 dapat = ' + _et2OfferedServices.length.toString());
      _totalOfferedServices.addAll(_et2OfferedServices);
      print('total dapat = ' + _totalOfferedServices.length.toString());
    }

    // finalize all data
    if (_totalOfferedServices.length == 0) {
      setBusy(false);
      empty = true;
    } else {
      final temp = _totalOfferedServices.map((offeredService) {
        if (!jobSeekersIDs.contains(offeredService.userID))
          return offeredService.userID;
      }).toList();
      jobSeekersIDs.addAll(temp);
      _jobSeekers = await _userFirestoreService
          .getUsersFromIDs(jobSeekersIDs)
          .then((val) async {
        return _jobSeekers = val;
      }).whenComplete(() {
        setBusy(false);
      });
    }
  }

  User getJobSeeker(String id) =>
      _jobSeekers.firstWhere((jobSeeker) => jobSeeker.id == id);
}

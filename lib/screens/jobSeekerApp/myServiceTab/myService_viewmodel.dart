import 'package:flutter/foundation.dart';
import 'package:workampus/app/locator.dart';
import 'package:workampus/models/offeredService.dart';
import 'package:workampus/services/offeredService/offeredService_firestore_service.dart';

import '../../viewmodel.dart';

class MyServiceViewModel extends ViewModel {
  final OfferedServiceFirestoreService _offeredServiceFirestoreService =
      locator<OfferedServiceFirestoreService>();

  bool empty = false;

  List<OfferedService> _offeredServices;
  List<OfferedService> get offeredServices => _offeredServices;

  Future initialise() async {
    setBusy(true);
    _offeredServices =
        await _offeredServiceFirestoreService.getMyServices(currentUser.id);
    print("my service dapatttt " + _offeredServices.length.toString());
    if (_offeredServices.length == 0) {
      setBusy(false);
      empty = true;
    } else {
      setBusy(false);
    }
  }

  OfferedService _offeredService;
  OfferedService get offeredService => _offeredService;

  Future fetchService(String id) async {
    setBusy(true);
    _offeredService =
        await _offeredServiceFirestoreService.getOfferedService(id);
  }

 

  // Create Service
  void offerService(
      {@required String title,
      @required String desc,
      @required String category,
      @required String type,
      @required String charges,
      @required String availability}) async {
    setBusy(true);
    final user = currentUser;
    final offerService = OfferedService.createNew(
        userID: user.id,
        title: title,
        desc: desc,
        category: category,
        type: type,
        availability: availability,
        charges: charges);

    final result = await _offeredServiceFirestoreService
        .createOfferedService(offerService);

    _offeredServiceFirestoreService.updateOfferedServiceID(result.id);

    setBusy(false);
  }

  //// Read Service

  //// Update Service
  void updateService({
    @required String id,
    @required String title,
    @required String desc,
    @required String category,
    @required String type,
    @required String charges,
    @required String availability,
  }) async {
    setBusy(true);

    await _offeredServiceFirestoreService.updateOfferedService(
      id,
      title: title,
      desc: desc,
      category: category,
      type: type,
      charges: charges,
      availability: availability,
    );

    setBusy(false);
  }

  // Delete Service
  void deleteService({
    @required String id,
  }) async {
    setBusy(true);

    _offeredServiceFirestoreService.deleteOfferedService(id);

    setBusy(false);
  }
}

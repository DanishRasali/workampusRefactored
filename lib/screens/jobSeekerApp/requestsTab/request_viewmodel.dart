import 'package:workampus/app/locator.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/services/contract/contract_firestore_service.dart';
import 'package:workampus/services/user/user_firestore_service.dart';

import '../../viewmodel.dart';

class RequestViewModel extends ViewModel {
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();
  final ContractFirestoreService _contractFirestoreService =
      locator<ContractFirestoreService>();

  bool empty = false;

  List<User> _requesters;
  List<User> get requesters => _requesters;

  List<Contract> _requestedContracts;
  List<Contract> get requestedContracts => _requestedContracts;

  //// Read Contract
  Future initialise() async {
    List<String> requestersIDs = [];

    // retrieve ongoing contracts from firebase
    setBusy(true);
    _requestedContracts =
        await _contractFirestoreService.getMyServiceRequests(currentUser.id);
    print("contract dapatttt " + _requestedContracts.length.toString());
    if (_requestedContracts.length == 0) {
      setBusy(false);
      empty = true;
    } else {
      final temp = _requestedContracts.map((requestedContract) {
        if (!requestersIDs.contains(requestedContract.currUserID))
          return requestedContract.currUserID;
      }).toList();
      requestersIDs.addAll(temp);
      print("requester ID dapatttt " + requestersIDs.length.toString());
      print("requester ID dapatttt " + requestersIDs.toString());
      _requesters = await _userFirestoreService
          .getUsersFromIDs(requestersIDs)
          .then((value1) async {
        return _requesters = value1;
      }).whenComplete(() async {
        setBusy(false);
      });
    }
  }

  User getRequester(String id) =>
      _requesters.firstWhere((requester) => requester.id == id);
}

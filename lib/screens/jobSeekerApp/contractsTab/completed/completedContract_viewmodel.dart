import 'package:workampus/app/locator.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/services/contract/contract_firestore_service.dart';
import 'package:workampus/services/user/user_firestore_service.dart';

import '../../../viewmodel.dart';

class CompletedContractViewModel extends ViewModel {
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();
  final ContractFirestoreService _contractFirestoreService =
      locator<ContractFirestoreService>();

  bool empty = false;

  List<User> _contractors;
  List<User> get contractors => _contractors;

  List<User> _currUsers;
  List<User> get currUsers => _currUsers;

  List<Contract> _contracts;
  List<Contract> get contracts => _contracts;

  List<Contract> _contracts2Step;
  List<Contract> get contracts2Step => _contracts2Step;

  //// Read Contract
  Future initialise() async {
    List<String> contractorsIDs = [];
    List<String> currUsersIDs = [];

    // retrieve ongoing contracts from firebase
    setBusy(true);
    _contracts = await _contractFirestoreService.getMyContractsByStatus1Step(
        currentUser.id, 'completed');
    _contracts2Step = await _contractFirestoreService
        .getMyContractsByStatus2Step(currentUser.id, 'completed');

    // add both list together
    _contracts.addAll(_contracts2Step);
    _contracts.sort((b, a) => a.createdAt.millisecondsSinceEpoch
        .compareTo(b.createdAt.millisecondsSinceEpoch));
    print(_contracts);

    // display data
    if (_contracts.length == 0) {
      setBusy(false);
      empty = true;
    } else {
      final temp = _contracts.map((ongoingContract) {
        if (!contractorsIDs.contains(ongoingContract.contractorID))
          return ongoingContract.contractorID;
      }).toList();
      contractorsIDs.addAll(temp);

      final temp1 = _contracts.map((ongoingContract) {
        if (!currUsersIDs.contains(ongoingContract.currUserID))
          return ongoingContract.currUserID;
      }).toList();
      currUsersIDs.addAll(temp1);

      _contractors = await _userFirestoreService
          .getUsersFromIDs(contractorsIDs)
          .then((value1) async {
        return _contractors = value1;
      }).whenComplete(() async {
        _currUsers = await _userFirestoreService
            .getUsersFromIDs(currUsersIDs)
            .then((value2) async {
          return _currUsers = value2;
        }).whenComplete(() => setBusy(false));
      });
    }
  }

  User getContractor(String id) =>
      _contractors.firstWhere((contractor) => contractor.id == id);
  User getCurrUser(String id) =>
      _currUsers.firstWhere((currUser) => currUser.id == id);
}

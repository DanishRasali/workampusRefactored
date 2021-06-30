import 'package:workampus/app/locator.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/services/contract/contract_firestore_service.dart';
import 'package:workampus/services/user/user_firestore_service.dart';

import '../../../viewmodel.dart';

class PendingContractViewModel extends ViewModel {
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();
  final ContractFirestoreService _contractFirestoreService =
      locator<ContractFirestoreService>();

  bool empty = false;

  List<User> _contractors;
  List<User> get contractors => _contractors;

  List<Contract> _contracts;
  List<Contract> get contracts => _contracts;

  //// Read Contract
  Future initialise() async {
    List<String> contractorsIDs = [];

    // retrieve ongoing contracts from firebase
    setBusy(true);
    _contracts = await _contractFirestoreService.getMyContractsByStatus1Step(
        currentUser.id, 'pending');
    if (_contracts.length == 0) {
      setBusy(false);
      empty = true;
    } else {
      final temp = _contracts.map((ongoingContract) {
        if (!contractorsIDs.contains(ongoingContract.contractorID))
          return ongoingContract.contractorID;
      }).toList();
      contractorsIDs.addAll(temp);
      _contractors = await _userFirestoreService
          .getUsersFromIDs(contractorsIDs)
          .then((value1) async {
        return _contractors = value1;
      }).whenComplete(() async {
        setBusy(false);
      });
    }
  }

  User getContractor(String id) =>
      _contractors.firstWhere((contractor) => contractor.id == id);
}

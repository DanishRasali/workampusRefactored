import 'package:workampus/app/locator.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/payment.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/services/contract/contract_firestore_service.dart';
import 'package:workampus/services/payment/payment_firestore_service.dart';
import 'package:workampus/services/user/user_firestore_service.dart';

import '../../viewmodel.dart';

class PaymentViewModel extends ViewModel {
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();
  final PaymentFirestoreService _paymentFirestoreService =
      locator<PaymentFirestoreService>();
  final ContractFirestoreService _contractFirestoreService =
      locator<ContractFirestoreService>();

  bool empty = false;

  List<User> _contractors;
  List<User> get contractors => _contractors;

  List<Payment> _payments;
  List<Payment> get payments => _payments;

  List<Contract> _contracts;
  List<Contract> get completedContracts => _contracts;

  User _updatedUser;
  User get updatedUser => _updatedUser;

  //// Read Contract
  Future initialise() async {
    List<String> contractsIDs = [];
    List<String> jobSeekersIDs = [];

    // retrieve ongoing contracts from firebase
    setBusy(true);

    _updatedUser = await _userFirestoreService.getUser(currentUser.id);

    _payments =
        await _paymentFirestoreService.getJobProviderPayments(currentUser.id);
    _payments.sort((b, a) => a.createdAt.millisecondsSinceEpoch
        .compareTo(b.createdAt.millisecondsSinceEpoch));
    print("payment dapatttt " + _payments.length.toString());
    if (_payments.length == 0) {
      setBusy(false);
      empty = true;
    } else {
      final temp = _payments.map((contract) {
        if (!contractsIDs.contains(contract.contractID))
          return contract.contractID;
      }).toList();
      contractsIDs.addAll(temp);
      print("contract ID dapatttt " + contractsIDs.length.toString());
      print("contract ID dapatttt " + contractsIDs.toString());
      _contracts = await _contractFirestoreService
          .getContractsFromIDs(contractsIDs)
          .then((value1) async {
        return _contracts = value1;
      }).whenComplete(() async {
        print("contract dapatttt " + _contracts.length.toString());
        final temp1 = _payments.map((contractor) {
          if (!jobSeekersIDs.contains(contractor.contractorID))
            return contractor.contractorID;
        }).toList();
        jobSeekersIDs.addAll(temp1);
        print("contractors ADAA " + jobSeekersIDs.length.toString());
        print(jobSeekersIDs);
        _contractors = await _userFirestoreService
            .getUsersFromIDs(jobSeekersIDs)
            .then((value2) {
          return _contractors = value2;
        }).whenComplete(() {
          setBusy(false);
        });
      });
    }
  }

  Contract getContract(String id) =>
      _contracts.firstWhere((completedContract) => completedContract.id == id);

  User getContractor(String id) =>
      _contractors.firstWhere((contractor) => contractor.id == id);
}

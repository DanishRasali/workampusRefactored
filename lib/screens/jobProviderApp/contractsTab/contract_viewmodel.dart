import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workampus/app/locator.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/payment.dart';
import 'package:workampus/models/rating.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/services/contract/contract_firestore_service.dart';
import 'package:workampus/services/payment/payment_firestore_service.dart';
import 'package:workampus/services/rating/rating_firestore_service.dart';
import 'package:workampus/services/user/user_firestore_service.dart';
import 'package:workampus/shared/toastAndDialog.dart';
import 'package:workampus/utils/datetime_timestamp_util.dart';

import '../../viewmodel.dart';
import '../jobProviderHome.dart';

class ContractViewModel extends ViewModel {
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();
  final ContractFirestoreService _contractFirestoreService =
      locator<ContractFirestoreService>();
  final PaymentFirestoreService _paymentFirestoreService =
      locator<PaymentFirestoreService>();
  final RatingFirestoreService _ratingFirestoreService =
      locator<RatingFirestoreService>();

  List<Rating> _jpRatings;
  Rating get jpRating => _jpRatings[0];

  List<Rating> _jsRatings;
  Rating get jsRating => _jsRatings[0];

  List<Contract> _myExistingContracts;
  List<Contract> get myExistingContracts => _myExistingContracts;

  Future initialise(String contractsID, String picID) async {
    setBusy(true);

    _jpRatings = await _ratingFirestoreService.getMyRatingForAContract(
        currentUser.id, contractsID);

    _jsRatings = await _ratingFirestoreService.getMyRatingForAContract(
        picID, contractsID);

    print("my rating dapatttt " + _jpRatings.length.toString());
    print("js rating dapatttt " + _jsRatings.length.toString());

    setBusy(false);
  }

  Future<bool> validate({
    @required String title,
    @required String contractorID,
  }) async {
    bool isValidated = true;
    _myExistingContracts =
        await _contractFirestoreService.getMyContracts(currentUser.id);
    print("Data ada " + _myExistingContracts.length.toString());
    if (_myExistingContracts != null) {
      _myExistingContracts.forEach((contract) {
        if (contract.contractorID == contractorID &&
            contract.title == title &&
            contract.status != 'completed') {
          print('FALSE');
          isValidated = false;
        }
      });
    }
    return isValidated;
  }

  // Create Contract
  void createContract({
    @required String currUserID,
    @required String contractorID,
    @required String title,
    @required String desc,
    @required String category,
    @required String type,
    @required String rate,
    @required String contractMessage,
    @required String dueDate,
    BuildContext context,
  }) async {
    setBusy(true);
    final user = currentUser;

    bool isValidated = await validate(contractorID: contractorID, title: title);

    if (isValidated != null) {
      print(isValidated);
      if (user.id == contractorID) {
        awesomeToast('Sorry, this service belongs to you');
        setBusy(false);
      } else if (!isValidated) {
        awesomeToast('this service is still in pending or ongoing');
      } else {
        final createContract = Contract.createNew(
          currUserID: user.id,
          contractorID: contractorID,
          title: title,
          desc: desc,
          category: category,
          type: type,
          rate: rate,
          contractMessage: contractMessage,
          dueDate: dueDate,
        );

        final result =
            await _contractFirestoreService.createContract(createContract);

        _contractFirestoreService.updateContractID(result.id);

        setBusy(false);
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    JobProviderHome(tab: 2, contractIndex: 0)),
            (route) => false);
        awesomeToast('Service Successfully Requested');
      }
    }
  }

  //// Update Service
  void updateContractStatus({
    @required String id,
    @required String status,
  }) async {
    setBusy(true);

    await _contractFirestoreService.updateContractStatus(
      id,
      status: status,
    );

    setBusy(false);
  }

  void successfulCardPayment({
    @required String contractID,
    @required num amount,
    @required String currUserID,
    @required User contractor,
  }) async {
    setBusy(true);

    num newCurrUserSpending = currentUser.spending + amount;
    print('Updated user Spending: ' + newCurrUserSpending.toString());

    num newContractorEarning = contractor.earning + amount;
    print('Updated contractor Earning: ' + newContractorEarning.toString());

    await _contractFirestoreService.updateContractStatus(
      contractID,
      status: 'completed',
    );

    final createPayment = Payment.createNew(
      amount: amount.toString(),
      contractID: contractID,
      currUserID: currUserID,
      contractorID: contractor.id,
      pending: false,
      type: 'card',
      paymentDate: timeNow + ' ' + usDate,
    );

    final result = await _paymentFirestoreService.createPayment(createPayment);
    _paymentFirestoreService.updatePaymentID(result.id);

    User user = new User(
      currentUser.id,
      currentUser.email,
      currentUser.address,
      currentUser.displayName,
      currentUser.desc,
      currentUser.photoUrl,
      currentUser.headerPhotoUrl,
      currentUser.userRating,
      currentUser.ratingCount,
      newCurrUserSpending,
      newContractorEarning,
      currentUser.roles,
    );

    await _userFirestoreService.updateUser(currentUser.id, user: user);
    setBusy(false);
  }

  void successfulCashPayment(
      {@required String contractID,
      @required String amount,
      @required String currUserID,
      @required String contractorID}) async {
    setBusy(true);

    await _contractFirestoreService.updateContractPayment(
      contractID,
      pendingPayment: true,
    );

    final createPayment = Payment.createNew(
      amount: amount,
      contractID: contractID,
      currUserID: currUserID,
      contractorID: contractorID,
      pending: true,
      type: 'cash',
      paymentDate: timeNow + ' ' + usDate,
    );

    final result = await _paymentFirestoreService.createPayment(createPayment);

    _paymentFirestoreService.updatePaymentID(result.id);
    setBusy(false);
  }

  void updateContractPending({
    @required String id,
    @required bool pendingComplete,
  }) async {
    setBusy(true);

    await _contractFirestoreService.updateContractPending(
      id,
      pendingComplete: pendingComplete,
    );

    setBusy(false);
  }

  // Delete Contract
  void deleteContract({
    @required String id,
  }) async {
    setBusy(true);

    _contractFirestoreService.deleteContract(id);

    setBusy(false);
  }

  void submitReview({
    @required String contractsID,
    @required String uid,
    @required String review,
    @required double starRating,
    @required User pic,
  }) async {
    setBusy(true);
    double avgRating;
    double realUserRating;
    final user = currentUser;
    final createReview = Rating.createNew(
      contractsID: contractsID,
      uid: uid,
      raterID: user.id,
      review: review,
      starRating: starRating,
    );

    final result = await _ratingFirestoreService.createRating(createReview);
    await _ratingFirestoreService.updateRatingID(result.id);

    await _contractFirestoreService.updateContractIsReviewed(contractsID,
        isReviewedByJP: true);

    // update uid average
    if (pic.ratingCount == 0) {
      avgRating = starRating;
    } else {
      if (pic.userRating == 0.1) {
        realUserRating = pic.userRating - 0.1;
      } else {
        realUserRating = pic.userRating;
      }
      avgRating = ((realUserRating * pic.ratingCount.toDouble()) + starRating) /
          (pic.ratingCount.toDouble() + 1);
    }

    User user2 = new User(
      pic.id,
      pic.email,
      pic.address,
      pic.displayName,
      pic.desc,
      pic.photoUrl,
      pic.headerPhotoUrl,
      avgRating,
      pic.ratingCount + 1,
      pic.spending,
      pic.earning,
      pic.roles,
    );

    await _userFirestoreService.updateUser(pic.id, user: user2);

    setBusy(false);
  }
}

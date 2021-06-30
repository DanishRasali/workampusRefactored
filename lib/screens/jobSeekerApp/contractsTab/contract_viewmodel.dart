import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workampus/app/locator.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/rating.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/services/contract/contract_firestore_service.dart';
import 'package:workampus/services/rating/rating_firestore_service.dart';
import 'package:workampus/services/user/user_firestore_service.dart';
import 'package:workampus/shared/toastAndDialog.dart';

import '../../viewmodel.dart';
import '../jobSeekerHome.dart';

class ContractViewModel extends ViewModel {
  final ContractFirestoreService _contractFirestoreService =
      locator<ContractFirestoreService>();
  final RatingFirestoreService _ratingFirestoreService =
      locator<RatingFirestoreService>();
  final UserFirestoreService _userFirestoreService =
      locator<UserFirestoreService>();

  List<Rating> _jsRatings;
  Rating get jsRating => _jsRatings[0];

  List<Rating> _jpRatings;
  Rating get jpRating => _jpRatings[0];

  List<Contract> _myExistingContracts;
  List<Contract> get myExistingContracts => _myExistingContracts;

  Future initialise(String contractsID, String picID) async {
    setBusy(true);

    _jsRatings = await _ratingFirestoreService.getMyRatingForAContract(
        currentUser.id, contractsID);

    _jpRatings = await _ratingFirestoreService.getMyRatingForAContract(
        picID, contractsID);

    print("my rating dapatttt " + _jsRatings.length.toString());
    print("jp rating dapatttt " + _jpRatings.length.toString());

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
        awesomeToast('Sorry, this jobs belongs to you');
        setBusy(false);
      } else if (!isValidated) {
        awesomeToast('this job is still in pending or ongoing');
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
                builder: (context) => JobSeekerHome(tab: 2, contractIndex: 0)),
            (route) => false);
        awesomeToast('Job Successfully Applied');
      }
    }
  }

  //// Update Contract Status
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

  // Delete Service
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
        isReviewedByJS: true);

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

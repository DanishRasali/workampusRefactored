import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/ongoing/ongoingContract_widget.dart';

import 'ongoingContract_viewmodel.dart';

class OngoingContract extends StatefulWidget {
  final int tab;
  OngoingContract({this.tab});

  @override
  _OngoingContractState createState() => _OngoingContractState();
}

class _OngoingContractState extends State<OngoingContract> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OngoingContractViewModel>.reactive(
      viewModelBuilder: () => OngoingContractViewModel(),
      onModelReady: (model) => model.initialise(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : model.empty
              ? Center(child: Text('There are no ongoing contracts'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: model.contracts == null
                              ? 1
                              : model.contracts.length,
                          itemBuilder: (context, index) {
                            final ongoingContract = model.contracts[index];
                            return OngoingContractWidget(
                              ongoingContract: ongoingContract,
                              contractor: model
                                  .getContractor(ongoingContract.contractorID),
                              currUser:
                                  model.getCurrUser(ongoingContract.currUserID),
                              userID: model.currentUser.id,
                            );
                          }),
                    ),
                  ],
                ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/completed/completedContract_widget.dart';

import 'completedContract_viewmodel.dart';

class CompletedContract extends StatefulWidget {
  final int tab;
  CompletedContract({this.tab});

  @override
  _CompletedContractState createState() => _CompletedContractState();
}

class _CompletedContractState extends State<CompletedContract> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompletedContractViewModel>.reactive(
      viewModelBuilder: () => CompletedContractViewModel(),
      onModelReady: (model) => model.initialise(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : model.empty
              ? Center(child: Text('There are no completed contracts'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: model.contracts == null
                            ? 1
                            : model.contracts.length,
                        itemBuilder: (context, index) {
                          final completedContract = model.contracts[index];
                          return CompletedContractWidget(
                            completedContract: completedContract,
                            contractor: model
                                .getContractor(completedContract.contractorID),
                            currUser:
                                model.getCurrUser(completedContract.currUserID),
                            userID: model.currentUser.id,
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobProviderApp/contractsTab/pending/pendingContract_viewmodel.dart';
import 'package:workampus/screens/jobProviderApp/contractsTab/pending/pendingContract_widget.dart';

class PendingContract extends StatefulWidget {
  final int tab;
  PendingContract({this.tab});

  @override
  _PendingContractState createState() => _PendingContractState();
}

class _PendingContractState extends State<PendingContract> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PendingContractViewModel>.reactive(
      viewModelBuilder: () => PendingContractViewModel(),
      onModelReady: (model) => model.initialise(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : model.empty
              ? Center(child: Text('There are no pending contracts'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: model.contracts == null
                              ? 1
                              : model.contracts.length,
                          itemBuilder: (context, index) {
                            final pendingContract = model.contracts[index];
                            return PendingContractWidget(
                              pendingContract: pendingContract,
                              jobSeeker: model
                                  .getContractor(pendingContract.contractorID),
                            );
                          }),
                    ),
                  ],
                ),
    );
  }
}

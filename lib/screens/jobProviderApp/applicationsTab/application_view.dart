// import 'package:dulang_new/services/food_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobProviderApp/applicationsTab/application_viewmodel.dart';
import 'package:workampus/screens/jobProviderApp/applicationsTab/application_widget.dart';

import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/colors.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({this.tab});
  final int tab;
  @override
  _ApplicationViewState createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicationViewModel>.reactive(
      viewModelBuilder: () => ApplicationViewModel(),
      onModelReady: (model) => model.initialise(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildAppBar(
            context, 'Job Applications', model.currentUser.photoUrl),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty
                ? Center(child: Text('You have zero job applications'))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: model.requestedContracts == null
                                ? 1
                                : model.requestedContracts.length,
                            itemBuilder: (context, index) {
                              final requestedContract =
                                  model.requestedContracts[index];
                              return JobApplicationWidget(
                                requestedContract: requestedContract,
                                requester: model
                                    .getRequester(requestedContract.currUserID),
                              );
                            }),
                      ),
                    ],
                  ),
      ),
    );
  }
}

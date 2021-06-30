// import 'package:dulang_new/services/food_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobSeekerApp/requestsTab/request_viewmodel.dart';
import 'package:workampus/screens/jobSeekerApp/requestsTab/request_widget.dart';

import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/colors.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({this.tab});
  final int tab;
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestViewModel>.reactive(
      viewModelBuilder: () => RequestViewModel(),
      onModelReady: (model) => model.initialise(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildAppBar(
            context, 'Service Requests', model.currentUser.photoUrl),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty
                ? Center(child: Text('You have zero service requests'))
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
                              return ServiceRequestWidget(
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

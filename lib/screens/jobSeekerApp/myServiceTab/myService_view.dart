import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobSeekerApp/myServiceTab/myService_viewmodel.dart';

import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';
import 'package:workampus/shared/colors.dart';

import 'offerService_view.dart';
import 'myService_widget.dart';

class MyServiceView extends StatefulWidget {
  const MyServiceView({this.tab});
  final int tab;
  @override
  _MyServiceViewState createState() => _MyServiceViewState();
}

class _MyServiceViewState extends State<MyServiceView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ViewModelBuilder<MyServiceViewModel>.reactive(
      viewModelBuilder: () => MyServiceViewModel(),
      onModelReady: (model) => model.initialise(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildAppBar(context, 'My Service', model.currentUser.photoUrl),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  model.empty
                      ? Container(
                          height: screenHeight - 233,
                          child: Center(
                              child: Text(
                                  'Your created services will appeared here')),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: model.offeredServices == null
                                ? 1
                                : model.offeredServices.length,
                            itemBuilder: (context, index) {
                              final offeredService =
                                  model.offeredServices[index];
                              return OfferedServiceWidget(
                                  offeredService: offeredService);
                            },
                          ),
                        ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: transparentButton("Offer New Service", offerService,
                        botttomBarColor, Colors.transparent, screenWidth),
                  ),
                ],
              ),
      ),
    );
  }

  offerService() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => OfferServiceScreen()));
}

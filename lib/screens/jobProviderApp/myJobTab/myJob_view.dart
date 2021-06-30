import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';
import 'package:workampus/shared/colors.dart';

import 'createJob_view.dart';
import 'myJob_viewmodel.dart';
import 'myJob_widget.dart';

class MyJobView extends StatefulWidget {
  const MyJobView({this.tab});
  final int tab;
  @override
  _MyJobViewState createState() => _MyJobViewState();
}

class _MyJobViewState extends State<MyJobView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ViewModelBuilder<MyJobViewModel>.reactive(
      viewModelBuilder: () => MyJobViewModel(),
      onModelReady: (model) => model.initialise(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildAppBar(context, 'My Jobs', model.currentUser.photoUrl),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  model.empty
                      ? Container(
                          height: screenHeight - 236,
                          child: Center(
                              child: Text('You have not created any jobs')),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: model.jobPostings == null
                                ? 1
                                : model.jobPostings.length,
                            itemBuilder: (context, index) {
                              final jobPosting = model.jobPostings[index];
                              return MyJobWidget(jobPosting: jobPosting);
                            },
                          ),
                        ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 18),
                    child: transparentButton("Create Job", jobPosting,
                        botttomBarColor, Colors.transparent, screenWidth),
                  ),
                ],
              ),
      ),
    );
  }

  jobPosting() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => OfferServiceScreen()));
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobSeekerApp/jobsTab/filterJob_view.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/colors.dart';

import 'job_viewmodel.dart';
import 'job_widget.dart';

class JobView extends StatefulWidget {
  const JobView({
    this.tab,
    this.ut1,
    this.ut2,
    this.ut3,
    this.ct1,
    this.ct2,
    this.ct3,
    this.et1,
    this.et2,
  });
  final int tab;

  // define uni type
  final bool ut1;
  final bool ut2;
  final bool ut3;

  // define chor type
  final bool ct1;
  final bool ct2;
  final bool ct3;

  // define err type
  final bool et1;
  final bool et2;

  @override
  _JobViewState createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {
  @override
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<JobViewModel>.reactive(
      viewModelBuilder: () => JobViewModel(),
      onModelReady: (model) => model.initialise(
        ut1: widget.ut1,
        ut2: widget.ut2,
        ut3: widget.ut3,
        ct1: widget.ct1,
        ct2: widget.ct2,
        ct3: widget.ct3,
        et1: widget.et1,
        et2: widget.et2,
      ),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar:
            buildAppBar(context, 'Explore Jobs', model.currentUser.photoUrl),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty
                ? Column(
                    children: [
                      buildTopFilter(screenWidth),
                      Expanded(
                          child: Center(
                              child:
                                  Text('Available jobs will appeared here'))),
                    ],
                  )
                : Column(
                    children: [
                      buildTopFilter(screenWidth),
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.totalJobPostings == null
                              ? 1
                              : model.totalJobPostings.length,
                          itemBuilder: (context, index) {
                            final jobPosting = model.totalJobPostings[index];
                            return JobPostingWidget(
                                jobPosting: jobPosting,
                                jobProvider:
                                    model.getJobProvider(jobPosting.userID));
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Container buildTopFilter(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(15),
      color: primaryColor,
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Filter:',
          //   style: TextStyle(
          //       color: Colors.black87,
          //       fontWeight: FontWeight.w600,
          //       fontSize: 15.5),
          // ),
          // SizedBox(height: 9),
          Container(
            height: 39.0,
            width: screenWidth,
            child: Material(
              shadowColor: Color.fromRGBO(57, 57, 57, 5),
              color: Colors.white,
              elevation: 2.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilterJobView(
                        ut1: widget.ut1,
                        ut2: widget.ut2,
                        ut3: widget.ut3,
                        ct1: widget.ct1,
                        ct2: widget.ct2,
                        ct3: widget.ct3,
                        et1: widget.et1,
                        et2: widget.et2,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      'Filter Jobs',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.5),
                    ),
                    Spacer(), //to fill the space
                    Transform.rotate(
                      angle: 90 * pi / 180,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(
                          Icons.chevron_right,
                          size: 31,
                          color: accentColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
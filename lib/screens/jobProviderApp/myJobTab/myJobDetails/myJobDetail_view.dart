// import 'package:dulang_new/services/food_data_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/jobPosting.dart';
import 'package:workampus/screens/jobProviderApp/myJobTab/myJobDetails/updateMyJob_view.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';

import '../../jobProviderHome.dart';
import '../myJob_viewmodel.dart';

class MyJobDetailView extends StatefulWidget {
  const MyJobDetailView({this.tab, this.jobPosting});
  final int tab;
  final JobPosting jobPosting;
  @override
  _MyJobDetailViewState createState() => _MyJobDetailViewState();
}

class _MyJobDetailViewState extends State<MyJobDetailView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<MyJobViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => MyJobViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'My Job Details'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 12.5, bottom: 12.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.jobPosting.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.jobPosting.category,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        ' - ',
                        style: TextStyle(
                            color: Color.fromRGBO(124, 124, 124, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        widget.jobPosting.type,
                        style: TextStyle(
                            color: Color.fromRGBO(124, 124, 124, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(
                  left: 9, right: 15, top: 9, bottom: 2.5),
              child: Transform.rotate(
                  angle: 180 * pi / 180,
                  child: Icon(Icons.format_quote,
                      color: Colors.black54, size: 34)),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15, bottom: 35.8),
              child: Text(
                widget.jobPosting.desc,
                style: TextStyle(
                    color: Color.fromRGBO(91, 91, 91, 1),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 12.5, bottom: 12.5),
              child: Text(
                widget.jobPosting.jobDate,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 12.5, bottom: 12.5),
              child: Row(
                children: [
                  Text(
                    'RM' + widget.jobPosting.rate.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(
                        color: Color.fromRGBO(124, 124, 124, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                  Text(
                    widget.jobPosting.status,
                    style: TextStyle(
                        color: Color.fromRGBO(124, 124, 124, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Spacer(),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 18),
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Row(
                    children: [
                      transparentButton("Update", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateMyJobView(
                                    jobPosting: widget.jobPosting)));
                      }, botttomBarColor, Colors.transparent,
                          (screenWidth - 39) / 2),
                      Spacer(),
                      transparentButton("Delete", () async {
                        print(widget.jobPosting.id);

                        awesomeDialog(
                          context,
                          'Are you sure?',
                          'Once you delete this Job, it will be gone forever.\n\nComfirm Deletion?',
                          () async {
                            model.deleteService(id: widget.jobPosting.id);
                            await Future.delayed(Duration(seconds: 1));
                            awesomeToast('Job Deleted!');

                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          JobProviderHome(tab: 3),
                                    ),
                                    (route) => false);
                          },
                        );
                      }, accentColor, Colors.transparent,
                          (screenWidth - 39) / 2),
                    ],
                  ),
                  SizedBox(height: 10),
                  transparentButton("Change Status", jobPostingDetail,
                      buttonGreenColor, Colors.transparent, screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> jobPostingDetail() async {}
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/jobPosting.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/contract_viewmodel.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/textField.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/topProfile.dart';

class ApplyJobScreen extends StatefulWidget {
  const ApplyJobScreen({this.tab, this.jobPosting, this.jobProvider});
  final int tab;
  final JobPosting jobPosting;
  final User jobProvider;
  @override
  _ApplyJobScreenState createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  final messageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<ContractViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => ContractViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Apply Job'),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  awesomeTopProfile(context, screenWidth, widget.jobProvider),
                  awesomeDivider(0.8, dividerColor),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 12.5, bottom: 12.5),
                    child: Text(
                      widget.jobPosting.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
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
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, bottom: 35.8),
                    child: Text(
                      widget.jobPosting.desc,
                      style: TextStyle(
                          color: Color.fromRGBO(91, 91, 91, 1),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          width: 0.8,
                          color: dividerColor,
                        ),
                      ),
                    ),
                  ),
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
                          widget.jobPosting.jobDate,
                          style: TextStyle(
                              color: Color.fromRGBO(124, 124, 124, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          width: 0.8,
                          color: dividerColor,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 16.8, bottom: 15),
                      child: awesomeTextField(
                          messageController,
                          'Enter job application message...',
                          6,
                          10,
                          screenWidth,
                          TextInputType.multiline,
                          'message'),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 18),
                    child: transparentButton("Apply Job", () async {
                      print(messageController.text);
                      if (_formKey.currentState.validate()) {
                        model.createContract(
                          currUserID: model.currentUser.id,
                          contractorID: widget.jobPosting.userID,
                          title: widget.jobPosting.title,
                          desc: widget.jobPosting.desc,
                          category: widget.jobPosting.category,
                          type: widget.jobPosting.type,
                          dueDate: widget.jobPosting.jobDate,
                          contractMessage: messageController.text,
                          rate: widget.jobPosting.rate,
                          context: context,
                        );
                      }
                    }, themeColor, Colors.transparent, screenWidth),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

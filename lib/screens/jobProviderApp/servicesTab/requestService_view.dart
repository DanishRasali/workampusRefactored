import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/offeredService.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobProviderApp/contractsTab/contract_viewmodel.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/textField.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/topProfile.dart';


class RequestServiceView extends StatefulWidget {
  const RequestServiceView({this.tab, this.offeredService, this.jobSeeker});
  final int tab;
  final OfferedService offeredService;
  final User jobSeeker;
  @override
  _RequestServiceViewState createState() => _RequestServiceViewState();
}

class _RequestServiceViewState extends State<RequestServiceView> {
  final messageController = TextEditingController();
  final jobDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<ContractViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => ContractViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Request Service'),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  awesomeTopProfile(context, screenWidth, widget.jobSeeker),
                  awesomeDivider(0.8, dividerColor),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 12.5, bottom: 12.5),
                    child: Text(
                      widget.offeredService.title,
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
                      widget.offeredService.desc,
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
                    child: Row(
                      children: [
                        Text(
                          'RM' + widget.offeredService.charges.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                        // Auto Resize Box
                        // SizedBox(
                        //   width: 286,
                        //   child: Expanded(
                        //     child: AutoSizeText(
                        //       widget.offeredService.availability,
                        //       style: TextStyle(
                        //           color: Color.fromRGBO(124, 124, 124, 1),
                        //           fontWeight: FontWeight.w400,
                        //           fontSize: 18),
                        //       maxLines: 1,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  awesomeDivider(0.8, dividerColor),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 12.5),
                        child: Text(
                          'Availability',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 6, bottom: 12.5),
                        child: Text(
                          widget.offeredService.availability,
                          style: TextStyle(
                              color: Color.fromRGBO(91, 91, 91, 1),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  awesomeDivider(0.8, dividerColor),
                  Spacer(),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: awesomeTextField(
                              messageController,
                              'Enter service request message...',
                              6,
                              10,
                              screenWidth,
                              TextInputType.multiline,
                              'message'),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Row(
                            children: [
                              Text(
                                'Request Date:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              Spacer(),
                              awesomeTextField(
                                jobDateController,
                                'DD/MM/YYYY',
                                1,
                                1,
                                200,
                                TextInputType.datetime,
                                'job date',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    alignment: Alignment.bottomCenter,
                    child: transparentButton("Request Service", () async {
                      print(messageController.text);
                      print(jobDateController.text);
                      if (_formKey.currentState.validate()) {
                        model.createContract(
                          currUserID: model.currentUser.id,
                          contractorID: widget.offeredService.userID,
                          title: widget.offeredService.title,
                          desc: widget.offeredService.desc,
                          category: widget.offeredService.category,
                          type: widget.offeredService.type,
                          dueDate: jobDateController.text,
                          rate: widget.offeredService.charges,
                          contractMessage: messageController.text,
                          context: context,
                        );
                      }
                    }, botttomBarColor, Colors.transparent, screenWidth),
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

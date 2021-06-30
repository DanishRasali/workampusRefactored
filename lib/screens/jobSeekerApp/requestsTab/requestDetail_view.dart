// import 'package:dulang_new/services/food_data_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/contract_viewmodel.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';
import 'package:workampus/shared/topProfile.dart';

import '../jobSeekerHome.dart';

class ServiceRequestDetailScreen extends StatefulWidget {
  const ServiceRequestDetailScreen({this.tab, this.user, this.contract});
  final int tab;
  final User user;
  final Contract contract;
  @override
  _ServiceRequestDetailScreenState createState() =>
      _ServiceRequestDetailScreenState();
}

class _ServiceRequestDetailScreenState
    extends State<ServiceRequestDetailScreen> {
  // int _selectedIndex = 0;
  // final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<ContractViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => ContractViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Service Requests Details'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            awesomeTopProfile(context, screenWidth, widget.user),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 12.5, bottom: 12.5),
              child: Text(
                widget.contract.title,
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
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15, bottom: 35.8),
              child: Text(
                widget.contract.contractMessage,
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
                    'RM' + widget.contract.rate.toString(),
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
                    widget.contract.dueDate,
                    style: TextStyle(
                        color: Color.fromRGBO(124, 124, 124, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            // buildTextField(),
            Spacer(),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 18),
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  transparentButton("Decline", () async {
                    awesomeDialog(
                      context,
                      'Are you sure?',
                      'Once you decline this request, you will not be able to see this requests again.\n\nComfirm Decline Request?',
                      () async {
                        model.deleteContract(id: widget.contract.id);
                        await Future.delayed(Duration(seconds: 1));
                        awesomeToast('Request\'s Declined!');

                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        JobSeekerHome(tab: 4)),
                                (route) => false);
                      },
                    );
                  }, accentColor, Colors.transparent, screenWidth),
                  // Row(
                  //   children: [
                  //     transparentButton("Decline", declineRequest, accentColor,
                  //         Colors.transparent, (screenWidth - 39) / 2),
                  //     Spacer(),
                  //     transparentButton(
                  //         "Reply",
                  //         serviceRequestDetail,
                  //         botttomBarColor,
                  //         Colors.transparent,
                  //         (screenWidth - 39) / 2),
                  //   ],
                  // ),
                  SizedBox(height: 10),
                  transparentButton("Accept Request", () async {
                    // model.updateContractStatus(id: widget.contract.id, status: 'ongoing');
                    model.updateContractStatus(
                      id: widget.contract.id,
                      status: 'ongoing',
                    );
                    awesomeToast('Request\'s accepted');
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    JobSeekerHome(tab: 2, contractIndex: 1)),
                            (route) => false);
                  }, buttonGreenColor, Colors.transparent, screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Container buildTextField() {
  //   return Container(
  //     padding: EdgeInsets.only(left: 15, right: 15, top: 16.8, bottom: 15),
  //     child: TextField(
  //       keyboardType: TextInputType.multiline,
  //       minLines: 4,
  //       maxLines: 10,
  //       style: TextStyle(
  //           color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.w500),
  //       decoration: InputDecoration(
  //         hintText: 'Tap to enter reply message...',
  //         hintStyle: TextStyle(
  //             color: Colors.black38,
  //             fontSize: 13.0,
  //             fontWeight: FontWeight.w400),
  //         fillColor: Colors.white,
  //         filled: true,
  //         contentPadding:
  //             EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
  //         enabledBorder: const OutlineInputBorder(
  //             borderSide: const BorderSide(color: dividerColor, width: 0.5)),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(2.0),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}

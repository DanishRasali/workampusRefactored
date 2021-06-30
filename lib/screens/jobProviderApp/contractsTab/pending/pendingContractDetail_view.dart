import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobProviderApp/contractsTab/contract_viewmodel.dart';
import 'package:workampus/screens/jobProviderApp/jobProviderHome.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';
import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';
import 'package:workampus/shared/topProfile.dart';

class PendingContractDetailView extends StatefulWidget {
  const PendingContractDetailView({this.tab, this.user, this.contract});
  final int tab;
  final User user;
  final Contract contract;
  @override
  _PendingContractDetailViewState createState() =>
      _PendingContractDetailViewState();
}

class _PendingContractDetailViewState extends State<PendingContractDetailView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder<ContractViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => ContractViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Pending Contract Details'),
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
            Spacer(),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 18),
              alignment: Alignment.bottomCenter,
              child: transparentButton("Cancel Request", () async {
                awesomeDialog(
                  context,
                  'Are you sure?',
                  'Once you cancel this request, job seeker will not be able to see your request again.\n\nComfirm Cancel Request?',
                  () async {
                    model.deleteContract(id: widget.contract.id);
                    await Future.delayed(Duration(seconds: 1));
                    awesomeToast('Request\'s Cancelled');

                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    JobProviderHome(tab: 2, contractIndex: 0)),
                            (route) => false);
                  },
                );
              }, accentColor, Colors.transparent, screenWidth),
            ),
          ],
        ),
      ),
    );
  }
}

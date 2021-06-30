// import 'package:dulang_new/services/food_data_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/payment.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobSeekerApp/paymentsTab/payment_viewmodel.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';
import 'package:workampus/shared/topProfile.dart';

import '../jobSeekerHome.dart';

class PaymentDetailView extends StatefulWidget {
  const PaymentDetailView({this.payment, this.contract, this.jobProvider});
  final Payment payment;
  final Contract contract;
  final User jobProvider;
  @override
  _PaymentDetailViewState createState() => _PaymentDetailViewState();
}

class _PaymentDetailViewState extends State<PaymentDetailView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<PaymentViewModel>.reactive(
      viewModelBuilder: () => PaymentViewModel(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Payment Details'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            awesomeTopProfile(context, screenWidth, widget.jobProvider),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 12.5, bottom: 12.5),
              child: Row(
                children: [
                  Text(
                    'RM' + widget.payment.amount,
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
                    widget.payment.type,
                    style: TextStyle(
                        color: Color.fromRGBO(124, 124, 124, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
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
                widget.contract.desc,
                style: TextStyle(
                    color: Color.fromRGBO(91, 91, 91, 1),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 18),
                alignment: Alignment.bottomCenter,
                child: widget.payment.pending
                    ? transparentButton("Cash Received", () async {
                        awesomeDialog(
                          context,
                          'Cash Received?',
                          'Once you confirm that you have received the cash, this contract will be completed and closed\n\nConfirm cash received?',
                          () async {
                            model.receiveCashPayment(
                              paymentID: widget.payment.id,
                              contractID: widget.contract.id,
                              amount: double.parse(widget.payment.amount),
                              jobProvider: widget.jobProvider,
                            );
                            await Future.delayed(Duration(seconds: 1));
                            awesomeToast('Cash Payment Received!');
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            JobSeekerHome(tab: 1)),
                                    (route) => false);
                          },
                        );
                      }, buttonGreenColor, Colors.transparent, screenWidth)
                    : Text("Received on " + widget.payment.paymentDate,
                        style: TextStyle(
                            color: buttonGreenColor,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

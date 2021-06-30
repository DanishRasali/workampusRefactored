import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/payment.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobProviderApp/paymentsTab/payment_viewmodel.dart';
import 'package:workampus/shared/appBar.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/topProfile.dart';

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
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 18),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                      widget.payment.pending
                          ? 'Pending Received Confirmation'
                          : "Paid on " + widget.payment.paymentDate,
                      style: TextStyle(
                          color: widget.payment.pending
                              ? accentColor
                              : buttonGreenColor,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w700))),
            ),
          ],
        ),
      ),
    );
  }
}

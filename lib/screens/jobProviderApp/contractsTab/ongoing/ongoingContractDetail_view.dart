import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobProviderApp/contractsTab/contract_viewmodel.dart';
import 'package:workampus/services/payment/payment_stripe_service.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';
import 'package:workampus/shared/topProfile.dart';

import '../../jobProviderHome.dart';

class OngoingContractDetailView extends StatefulWidget {
  const OngoingContractDetailView({this.tab, this.user, this.contract});
  final int tab;
  final User user;
  final Contract contract;
  @override
  _OngoingContractDetailViewState createState() =>
      _OngoingContractDetailViewState();
}

class _OngoingContractDetailViewState extends State<OngoingContractDetailView> {
  String paymentMethod = 'Card';
  var _paymentMethods = ['Card', 'Cash'];

  var _currentSelectedPaymentMethod = 'Card';

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    String amount = widget.contract.rate;
    String newAmount;
    if (amount.contains('.')) {
      print("ADA TITIK");
      print(amount.length);
      print(amount.indexOf('.'));
      int index = amount.indexOf('.');
      int length = amount.length;
      if (length - index == 2) {
        //buang titik + tambah satu 0
        newAmount = amount.replaceAll('.', '');
        newAmount = newAmount + '0';
        print('New is ' + newAmount);
      } else if (length - index == 3) {
        newAmount = amount.replaceAll('.', '');
        print('New is ' + newAmount);
      }
    } else {
      newAmount = amount + '00';
      print(newAmount);
    }

    return ViewModelBuilder<ContractViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => ContractViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Ongoing Contract Details'),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
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
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, bottom: 35.8),
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
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 18),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
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
                        widget.contract.pendingComplete == false
                            ? Text('In Progress',
                                style: TextStyle(
                                    color: accentColor,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w700))
                            : widget.contract.pendingPayment
                                ? Text('Please Make Payment',
                                    style: TextStyle(
                                        color: accentColor,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w700))
                                : Column(
                                    children: [
                                      Container(
                                        width: screenWidth,
                                        child: Row(
                                          children: [
                                            Text(
                                              'SELECT PAYMENT METHOD:',
                                              style: TextStyle(
                                                  color: grey,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.5),
                                            ),
                                            Spacer(),
                                            Container(
                                              child: DropdownButton<String>(
                                                underline: Container(),
                                                items: _paymentMethods.map(
                                                    (String
                                                        dropDownStringItem) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: dropDownStringItem,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10),
                                                        Container(
                                                          child: Text(
                                                            dropDownStringItem +
                                                                " ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                fontSize: 16.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                                icon: Transform.rotate(
                                                    angle: 90 * pi / 180,
                                                    child: Icon(
                                                        Icons.chevron_right,
                                                        color: Colors.black54)),
                                                onChanged:
                                                    (String newRolesSelected) {
                                                  setState(() {
                                                    _currentSelectedPaymentMethod =
                                                        newRolesSelected;
                                                    paymentMethod =
                                                        _currentSelectedPaymentMethod;
                                                  });
                                                },
                                                value:
                                                    _currentSelectedPaymentMethod,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      transparentButton(
                                          "Confirm Completion & Pay", () async {
                                        if (paymentMethod == 'Cash') {
                                          awesomeDialog(
                                            context,
                                            'Cash Payment Procedure',
                                            '1. Pay to Job Seeker by cash physically.\n2. Job Seeker tap on "Cash Received" on the app.\n3. Payment Successful.\n\nConfirm pay by cash?',
                                            () async {
                                              model.successfulCashPayment(
                                                amount: widget.contract.rate,
                                                contractID: widget.contract.id,
                                                currUserID:
                                                    model.currentUser.id,
                                                contractorID: widget.user.id,
                                              );
                                              await Future.delayed(
                                                  Duration(seconds: 1));
                                              awesomeToast(
                                                  'Notified Job Seeker!');
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              JobProviderHome(
                                                                  tab: 1)),
                                                      (route) => false);
                                            },
                                          );
                                        } else {
                                          var response = await StripeService
                                              .payWithNewCard(
                                                  amount: newAmount,
                                                  currency: 'MYR');
                                          print(response.success.toString());
                                          awesomeToast(response.message);
                                          if (response.success) {
                                            model.successfulCardPayment(
                                              amount: double.parse(
                                                  widget.contract.rate),
                                              contractID: widget.contract.id,
                                              currUserID: model.currentUser.id,
                                              contractor: widget.user,
                                            );
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            JobProviderHome(
                                                                tab: 1)),
                                                    (route) => false);
                                          }
                                        }
                                      }, buttonGreenColor, Colors.transparent,
                                          screenWidth),
                                    ],
                                  ),
                      ],
                    ),
                  ),
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

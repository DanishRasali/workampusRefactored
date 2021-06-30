// import 'package:dulang_new/services/food_data_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobSeekerApp/paymentsTab/payment_widget.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';
import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/toastAndDialog.dart';

import '../jobSeekerHome.dart';
import 'payment_viewmodel.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({this.tab});
  final int tab;
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final topUpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // getPayments();
    return ViewModelBuilder<PaymentViewModel>.reactive(
      viewModelBuilder: () => PaymentViewModel(),
      onModelReady: (model) => model.initialise(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildAppBar(context, 'Payments', model.currentUser.photoUrl),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty
                ? Center(child: Text('There are no pending payments'))
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        color: primaryColor,
                        height: 105,
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Text(
                                  'Available Payouts: ',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.5),
                                ),
                                Text(
                                  'RM' + model.updatedUser.earning.toString(),
                                  style: TextStyle(
                                      color: accentColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.5),
                                ),
                              ],
                            ),
                            SizedBox(height: 9),
                            Container(
                              height: 57.5,
                              width: screenWidth,
                              child: Material(
                                shadowColor: Color.fromRGBO(57, 57, 57, 5),
                                color: Colors.white,
                                elevation: 2.0,
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      SizedBox(width: 20),
                                      Text(
                                        'Earnings History',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.payments == null
                              ? 1
                              : model.payments.length,
                          itemBuilder: (context, index) {
                            final payment = model.payments[index];
                            return PaymentWidget(
                              payment: payment,
                              contract: model.getContract(payment.contractID),
                              jobProvider:
                                  model.getContractor(payment.currUserID),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: transparentButton("Withdraw", () async {
                          num formattedAmount;
                          await awesomeInputDialog(
                              context,
                              'Withdraw Funds',
                              'Payments will be processed in two business days\n Please enter amount:\n',
                              topUpController, () {
                            if (topUpController.text != '') {
                              var rate = double.parse(topUpController.text);
                              var formattedString = rate.toStringAsFixed(2);
                              formattedAmount = double.parse(formattedString);
                              print('double conversionnn');
                              print('formatted rate is = ' +
                                  formattedAmount.toString());
                              if (formattedAmount <=
                                  model.currentUser.earning) {
                                print('calculating balance..');
                                model.withdrawFund(amount: formattedAmount);
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobSeekerHome(tab: 1)),
                                        (route) => false);
                              } else if (formattedAmount >
                                  model.currentUser.earning) {
                                awesomeToast('Amount Exceeded!');
                              }
                            } else {
                              awesomeToast('Please enter amount!');
                            }
                          }, 'Max RM' + model.updatedUser.earning.toString());
                        }, buttonGreenColor, Colors.transparent, screenWidth),
                      ),
                    ],
                  ),
      ),
    );
  }
}

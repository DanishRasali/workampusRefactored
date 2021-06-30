import 'package:flutter/material.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/payment.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/shared/colors.dart';

import 'paymentDetail_view.dart';

class PaymentWidget extends StatelessWidget {
  final Payment payment;
  final Contract contract;
  final User jobProvider;

  PaymentWidget({this.payment, this.contract, this.jobProvider});

  @override
  Widget build(BuildContext context) {
    print(payment.amount.toString());
    print(jobProvider.displayName);
    print(payment.type);
    print(contract.title);
    // print(payment.status);
    print(payment.paymentDate);
    return Material(
      color: bgColor,
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0.7,
              color: dividerColor,
            ),
          ),
        ),
        padding: EdgeInsets.only(top: 19, bottom: 19),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentDetailView(
                      payment: payment,
                      contract: contract,
                      jobProvider: jobProvider),
                ),
              );
            },
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: Text(
                    'RM' + payment.amount.toString(),
                    style: TextStyle(
                        color: accentColor,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              jobProvider.displayName,
                              style: TextStyle(
                                  color: Color.fromRGBO(91, 91, 91, 1),
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              ' - ',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              payment.type,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          contract.title,
                          style: TextStyle(
                              color: Color.fromRGBO(91, 91, 91, 1),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              payment.pending ? 'Pay by Cash!' : 'Successful',
                              style: payment.pending
                                  ? TextStyle(
                                      color: accentColor,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600)
                                  : TextStyle(
                                      color: buttonGreenColor,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600),
                            ),
                            Text(
                              ' - ',
                              style: TextStyle(
                                  color: payment.pending ? bgColor : Colors.black54,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              payment.paymentDate,
                              style: TextStyle(
                                  color: payment.pending ? bgColor : Colors.black54,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

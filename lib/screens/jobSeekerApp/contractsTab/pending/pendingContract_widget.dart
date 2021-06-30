import 'package:flutter/material.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/pending/pendingContractDetail_view.dart';
import 'package:workampus/shared/colors.dart';

class PendingContractWidget extends StatelessWidget {
  final Contract pendingContract;
  final User jobProvider;

  PendingContractWidget({this.pendingContract, this.jobProvider});

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.only(top: 16.5, bottom: 10.5),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PendingContractDetailView(
                          contract: pendingContract, user: jobProvider)));
            },
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: Text(
                    pendingContract.title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              pendingContract.category,
                              style: TextStyle(
                                  color: Color.fromRGBO(91, 91, 91, 1),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              ' - ',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              pendingContract.type,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.5),
                        Row(
                          children: [
                            Text(
                              'Due ',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              pendingContract.dueDate,
                              style: TextStyle(
                                  color: accentColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          'Rate RM' + pendingContract.rate.toString(),
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 8.5),
                        Text(
                          jobProvider.displayName,
                          style: TextStyle(
                              color: Color.fromRGBO(91, 91, 91, 1),
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600),
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

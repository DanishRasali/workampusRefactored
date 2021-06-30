import 'package:flutter/material.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/ongoing/ongoingContractDetail_view.dart';
import 'package:workampus/shared/colors.dart';

class OngoingContractWidget extends StatelessWidget {
  final Contract ongoingContract;
  final User contractor;
  final User currUser;
  final String userID;

  OngoingContractWidget(
      {this.ongoingContract, this.contractor, this.currUser, this.userID});

  @override
  Widget build(BuildContext context) {
    // determine pic
    User _pic;
    if (contractor.id == userID) {
      _pic = currUser;
    } else {
      _pic = contractor;
    }

    //determine status
    Text _status;
    if (ongoingContract.pendingComplete) {
      _status = Text(
        ' - awaiting payment ✓',
        style: TextStyle(
            color: buttonGreenColor, fontSize: 13.0, fontWeight: FontWeight.w400),
      );
    } else if (!ongoingContract.pendingComplete) {
      _status = Text(
        ' - in Progress',
        style: TextStyle(
            color: Colors.orange, fontSize: 13.0, fontWeight: FontWeight.w400),
      );
    }  


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
                      builder: (context) => OngoingContractDetailView(
                          contract: ongoingContract, user: _pic)));
            },
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: Text(
                    ongoingContract.title,
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
                              ongoingContract.category,
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
                              ongoingContract.type,
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
                              ongoingContract.dueDate,
                              style: TextStyle(
                                  color: accentColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          'Rate RM' + ongoingContract.rate.toString(),
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 8.5),
                        Row(
                          children: [
                            Text(
                              _pic.displayName,
                              style: TextStyle(
                                  color: Color.fromRGBO(91, 91, 91, 1),
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600),
                            ),
                            _status
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

import 'package:flutter/material.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/completed/completedContractDetail_view.dart';
import 'package:workampus/shared/colors.dart';

class CompletedContractWidget extends StatelessWidget {
  final Contract completedContract;
  final User contractor;
  final User currUser;
  final String userID;

  CompletedContractWidget(
      {this.completedContract, this.contractor, this.currUser, this.userID});

  @override
  Widget build(BuildContext context) {
    // determine pic
    User _pic;
    if (contractor.id == userID) {
      _pic = currUser;
    } else {
      _pic = contractor;
    }

    // determine status
    Text _status;
    if (!completedContract.isReviewedByJS && completedContract.isReviewedByJP) {
      _status = Text(
        ' - review now!',
        style: TextStyle(
            color: accentColor, fontSize: 13.0, fontWeight: FontWeight.w400),
      );
    } else if (!completedContract.isReviewedByJS &&
        !completedContract.isReviewedByJP) {
      _status = Text(
        ' - review now',
        style: TextStyle(
            color: Colors.orange,
            fontSize: 13.0,
            fontWeight: FontWeight.w400),
      );
    } else if (completedContract.isReviewedByJS &&
        !completedContract.isReviewedByJP) {
      _status = Text(
        ' - reviewed ✓',
        style: TextStyle(
            color: buttonGreenColor,
            fontSize: 13.0,
            fontWeight: FontWeight.w400),
      );
    } else if (completedContract.isReviewedByJS &&
        completedContract.isReviewedByJP) {
      _status = Text(
        ' - reviewed ✓✓',
        style: TextStyle(
            color: buttonGreenColor,
            fontSize: 13.0,
            fontWeight: FontWeight.w400),
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
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompletedContractDetailView(
                          contract: completedContract, pic: _pic)));
            },
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: Text(
                    completedContract.title,
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
                              completedContract.category,
                              style: TextStyle(
                                  color: Color.fromRGBO(91, 91, 91, 1),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              ' - ' + completedContract.type,
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
                              completedContract.dueDate,
                              style: TextStyle(
                                  color: accentColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          'Rate RM' + completedContract.rate.toString(),
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:workampus/models/contract.dart';

import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobProviderApp/applicationsTab/applicationDetail_view.dart';
import 'package:workampus/shared/colors.dart';

class JobApplicationWidget extends StatelessWidget {
  final User requester;
  final Contract requestedContract;

  JobApplicationWidget({this.requester, this.requestedContract});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat.yMMMMd('en_US').format(requestedContract.createdAt);
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
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JobApplicationDetailScreen(
                          user: requester, contract: requestedContract)));
            },
            child: Column(
              children: [
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                          height: 53,
                          width: 53,
                          color: Colors.blue,
                          child: requester.photoUrl == ''
                              ? Icon(
                                  FontAwesomeIcons.user,
                                  color: black,
                                )
                              : CachedNetworkImage(
                                  imageUrl: requester.photoUrl,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                        ),
                    
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            requester.displayName,
                            style: TextStyle(
                                color: Colors.black87,
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
                            requester.address,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w400),
                          ),
                          Spacer(),
                          Text(
                            formattedDate,
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Text(
                        requestedContract.title,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    requestedContract.contractMessage.length > 43
                                  ? '${requestedContract.contractMessage.substring(0, 43)}...'
                                  : requestedContract.contractMessage,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

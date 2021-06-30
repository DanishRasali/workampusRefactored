import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/profile/publicProfile_view.dart';
import 'package:workampus/shared/starRating.dart';

import 'colors.dart';

awesomeTopProfile(BuildContext context, double screenWidth, User user) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublicProfileView(user),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 67),
      height: 116.5,
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 75,
                width: 75,
                color: Colors.blue,
                child: user.photoUrl == ''
                    ? Icon(
                        FontAwesomeIcons.user,
                        color: black,
                      )
                    : CachedNetworkImage(
                        imageUrl: user.photoUrl,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
              ),
            ),
          ),
          SizedBox(width: 12.5),
          Center(
            child: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.displayName,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 21)),
                  SizedBox(height: 1),
                  Row(
                    children: [
                      awesomeRatingBarIndicator(
                          user.userRating == 0.1 ? 0 : user.userRating, 19.00),
                      Text(
                        ' (' + user.ratingCount.toString() + ')',
                        // widget.user.totReview.toString()
                        style: TextStyle(
                            color: accentColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    user.address,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

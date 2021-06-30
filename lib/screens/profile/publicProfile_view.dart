import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/profile/profile_viewmodel.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/chatBubble.dart';
import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/starRating.dart';

class PublicProfileView extends StatefulWidget {
  const PublicProfileView(this.user);
  final User user;
  @override
  _PublicProfileViewState createState() => _PublicProfileViewState();
}

class _PublicProfileViewState extends State<PublicProfileView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => model.initialise(widget.user),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, '',
            elevation: 0, bgColor: Colors.transparent),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 18, top: 98),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        'Hello, I\'m ' + widget.user.displayName,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            color: Colors.black87),
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          awesomeRatingBarIndicator(
                              widget.user.userRating, 18.00),
                          Text(
                            ' (' + widget.user.ratingCount.toString() + ')',
                            style: TextStyle(
                                color: accentColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Joined in June 2019',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Spacer(),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 80,
                        width: 80,
                        color: Colors.blue,
                        child: widget.user.photoUrl == ''
                            ? Icon(
                                FontAwesomeIcons.user,
                                color: black,
                              )
                            : CachedNetworkImage(
                                imageUrl: widget.user.photoUrl,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            awesomeDivider(0.8, dividerColor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 14),
                  child: Text(
                    'About',
                    style: TextStyle(
                        color: Color.fromRGBO(91, 91, 91, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9, right: 15, top: 5),
                  child: Transform.rotate(
                      angle: 180 * pi / 180,
                      child: Icon(Icons.format_quote,
                          color: Color.fromRGBO(91, 91, 91, 1), size: 37)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15, top: 6),
                  child: Text(
                    widget.user.desc == ''
                        ? 'Hi, I\'m ${widget.user.displayName} from ${widget.user.address}. I\'m new to Workampus and happy to help each other.\nHope to see you\n\nCheers'
                        : widget.user.desc,
                    style: TextStyle(
                        color: Color.fromRGBO(91, 91, 91, 1),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 20, bottom: 18),
                  child: awesomeDivider(1.5, Color.fromRGBO(91, 91, 91, 1),
                      width: 33),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 11.5, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Color.fromRGBO(91, 91, 91, 1),
                      ),
                      SizedBox(width: 11.5),
                      Text(
                        'Lives in ' + widget.user.address,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 14, left: 11.5, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_box,
                        color: Color.fromRGBO(91, 91, 91, 1),
                      ),
                      SizedBox(width: 11.5),
                      Text(
                        'Registered as ' + widget.user.roles,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
            awesomeDivider(0.8, dividerColor),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 14),
              child: Text(
                model.isBusy
                    ? 'Reviews'
                    : model.myRatings.length.toString() + ' Reviews',
                style: TextStyle(
                    color: Color.fromRGBO(91, 91, 91, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
            model.isBusy
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 5),
                        padding: const EdgeInsets.only(left: 6, right: 13),
                        scrollDirection: Axis.horizontal,
                        itemCount: model.myRatings == null
                            ? 1
                            : model.myRatings.length,
                        itemBuilder: (context, index) {
                          final myRating = model.myRatings[index];
                          return getProfileRating(
                              context,
                              model.getRater(myRating.raterID).displayName,
                              myRating.starRating,
                              myRating.review);
                        }),
                  ),
            SizedBox(height: 13)
          ],
        ),
      ),
    );
  }
}

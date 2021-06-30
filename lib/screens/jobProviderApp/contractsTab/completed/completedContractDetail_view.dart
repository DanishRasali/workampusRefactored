import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/contract.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/jobProviderApp/contractsTab/contract_viewmodel.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/chatBubble.dart';
import 'package:workampus/shared/textField.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';
import 'package:workampus/shared/topProfile.dart';

class CompletedContractDetailView extends StatefulWidget {
  const CompletedContractDetailView({this.tab, this.pic, this.contract});
  final int tab;
  final User pic;
  final Contract contract;
  @override
  _CompletedContractDetailViewState createState() =>
      _CompletedContractDetailViewState();
}

class _CompletedContractDetailViewState
    extends State<CompletedContractDetailView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final reviewDescController = TextEditingController();
  double rating;
  bool notRated = false;
  bool halfRated = false;
  bool fullRated = false;

  @override
  void initState() {
    super.initState();
    if (!widget.contract.isReviewedByJS && !widget.contract.isReviewedByJP) {
      notRated = true;
    } else if (widget.contract.isReviewedByJS &&
        !widget.contract.isReviewedByJP) {
      halfRated = true;
    } else if (widget.contract.isReviewedByJS &&
        widget.contract.isReviewedByJP) {
      fullRated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = AppBar().preferredSize.height;

    print('is it half rated? ' + halfRated.toString());

    return ViewModelBuilder<ContractViewModel>.reactive(
      viewModelBuilder: () => ContractViewModel(),
      onModelReady: (model) =>
          model.initialise(widget.contract.id, widget.pic.id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Rate and Review'),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  height: halfRated || fullRated
                      ? null
                      : screenHeight - appBarHeight - statusBarHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      awesomeTopProfile(context, screenWidth, widget.pic),
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
                          widget.contract.desc,
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
                      halfRated || fullRated ? SizedBox(height: 0) : Spacer(),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: widget.contract.isReviewedByJP ? 16 : 20,
                            left: 15,
                            right: 15,
                            top: widget.contract.isReviewedByJP ? 0 : 12.5),
                        color: bgColor,
                        child: widget.contract.isReviewedByJP
                            ? Column(
                                children: [
                                  getSenderRating(
                                      context,
                                      model.currentUser.displayName,
                                      model.jpRating.starRating,
                                      model.jpRating.review),
                                  widget.contract.isReviewedByJS
                                      ? getReceiverRating(
                                          context,
                                          widget.pic.displayName,
                                          model.jsRating.starRating,
                                          model.jsRating.review)
                                      : SizedBox(height: 0),
                                  SizedBox(height: 10),
                                  Text(
                                    'JOB COMPLETED',
                                    style: TextStyle(
                                        color: buttonGreenColor,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget.contract.isReviewedByJS
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: getReceiverRating(
                                              context,
                                              widget.pic.displayName,
                                              model.jsRating.starRating,
                                              model.jsRating.review),
                                        )
                                      : SizedBox(height: 0),
                                  Form(
                                    key: _formKey,
                                    child: awesomeTextFieldNoError(
                                      reviewDescController,
                                      'Tell us your working experience with ' +
                                          widget.pic.displayName +
                                          '...',
                                      5,
                                      10,
                                      screenWidth,
                                      TextInputType.multiline,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  RatingBar.builder(
                                    glow: false,
                                    initialRating: 0,
                                    minRating: 0.5,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 40,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: accentColor,
                                    ),
                                    onRatingUpdate: (v) {
                                      rating = v;
                                      print(rating.toString());
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  transparentButton("Submit Review", () async {
                                    print(rating.toString());
                                    print(reviewDescController.text);
                                    if (_formKey.currentState.validate()) {
                                      print(reviewDescController.text);
                                      print(rating.toString());
                                      if (reviewDescController.text == '' ||
                                          reviewDescController.text == ' ' ||
                                          rating == null) {
                                        awesomeSingleDialog(
                                          context,
                                          'Did you forget to rate?',
                                          'You may please write your review and slide on the star to rate your working experience',
                                          () async {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                        );
                                      } else {
                                        model.submitReview(
                                            contractsID: widget.contract.id,
                                            uid: widget.pic.id,
                                            review: reviewDescController.text,
                                            starRating: rating,
                                            pic: widget.pic);
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                        awesomeToast('Review Submitted :D');
                                        Navigator.pop(context);
                                      }
                                    }
                                  }, accentColor, Colors.transparent,
                                      screenWidth),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

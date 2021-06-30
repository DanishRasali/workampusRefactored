import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

import 'starRating.dart';

getSenderRating(BuildContext context, String username, double starRating,
        String content) =>
    ChatBubble(
      clipper: ChatBubbleClipper6(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: Color.fromRGBO(230, 230, 230, 1),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            awesomeRatingBarIndicator(starRating, 17.00),
            SizedBox(height: 8),
            Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );

getReceiverRating(BuildContext context, String username, double starRating,
        String content) =>
    ChatBubble(
      clipper: ChatBubbleClipper6(type: BubbleType.receiverBubble),
      backGroundColor: Color.fromRGBO(248, 248, 248, 1),
      margin: EdgeInsets.only(top: 20),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            awesomeRatingBarIndicator(starRating, 17.00),
            SizedBox(height: 8),
            Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );

    getProfileRating(BuildContext context, String username, double starRating,
        String content) =>
    ChatBubble(
      clipper: ChatBubbleClipper6(type: BubbleType.receiverBubble),
      backGroundColor: Color.fromRGBO(240, 240, 240, 1),
      margin: EdgeInsets.only(top: 20),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9 - 7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            awesomeRatingBarIndicator(starRating, 17.00),
            SizedBox(height: 8),
            Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );

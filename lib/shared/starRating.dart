import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'colors.dart';

awesomeRatingBarIndicator(double rating, double starSize) {
  return RatingBarIndicator(
    rating: rating,
    itemBuilder: (context, index) => Icon(
      Icons.star,
      color: accentColor,
    ),
    itemCount: 5,
    itemSize: starSize,
    direction: Axis.horizontal,
  );
}



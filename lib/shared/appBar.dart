import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workampus/screens/profile/profile_view.dart';

import 'colors.dart';

AppBar buildAppBar(BuildContext context, String title, String photoUrl) {
  return AppBar(
    centerTitle: true,
    title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
    leading: Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileView()));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 37,
              width: 37,
              color: Colors.blue,
              child: photoUrl == ''
                  ? Icon(
                      FontAwesomeIcons.user,
                      color: black,
                    )
                  : CachedNetworkImage(
                      imageUrl: photoUrl,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
            // Image.network(
            //     'https://lh3.googleusercontent.com/proxy/Ewyo9pQAfwpwhmEDcrzLggT5Wjwy6bMCsP9PCytXSwZDv58vUJGAoKbp1BQK7IYsZxCLR_kWE0TmYD--kyUyKuwSf3pttVi3sUjWJXAMcOkk',
            //     fit: BoxFit.contain,
            //     height: 40),
          ),
        ),
      ],
    ),
  );
}

AppBar buildSectionBar(BuildContext context, String title,
    {double elevation, Color bgColor}) {
  return AppBar(
    centerTitle: true,
    elevation: elevation,
    backgroundColor: bgColor,
    title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
    leading: Row(
      children: <Widget>[
        SizedBox(width: 2.0),
        Container(
          height: 37,
          width: 37,
          child: IconButton(
            icon: Icon(
              CupertinoIcons.chevron_left,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ),
  );
}

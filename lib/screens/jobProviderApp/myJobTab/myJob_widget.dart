import 'package:flutter/material.dart';
import 'package:workampus/models/jobPosting.dart';
import 'package:workampus/shared/colors.dart';
import 'myJobDetails/myJobDetail_view.dart';



class MyJobWidget extends StatelessWidget {
  final JobPosting jobPosting;

  MyJobWidget({this.jobPosting});


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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyJobDetailView(jobPosting: jobPosting)));
            },
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: Text(
            jobPosting.title,
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
                      jobPosting.category,
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
                      jobPosting.type,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.5),
                        Text(
                          'RM' + jobPosting.rate.toString(),
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                  jobPosting.jobDate,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 8.5),
                        Row(
                          children: [
                            Text(
                      jobPosting.desc.length > 46
                                  ? '${jobPosting.desc.substring(0, 46)}...'
                                  : jobPosting.desc,
                              style: TextStyle(
                                  color: Color.fromRGBO(91, 91, 91, 1),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              'more',
                              style: TextStyle(
                                  color: accentColor,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600),
                            ),
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

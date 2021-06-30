import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/jobPosting.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/textField.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';

import '../../jobProviderHome.dart';
import '../myJob_viewmodel.dart';

class UpdateMyJobView extends StatefulWidget {
  const UpdateMyJobView({this.tab, this.jobPosting});
  final JobPosting jobPosting;
  final int tab;

  @override
  _UpdateMyJobViewState createState() => _UpdateMyJobViewState();
}

class _UpdateMyJobViewState extends State<UpdateMyJobView> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController jobDescController = TextEditingController();
  TextEditingController jobRateController = TextEditingController();
  TextEditingController jobDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedJobCtg = 'University Jobs';

  var _jobCategory = ['University Jobs', 'Chores', 'Errands'];

  var _univCtgType = ['Documentation and Editing', 'Tutoring', 'Assiting'];
  var _chorCtgType = ['Cleaning', 'Laundry', 'General Helper'];
  var _erraCtgType = ['Delivery/Pickup', 'Shopping'];

  var _currentCtgSelected = 'University Jobs';
  var _currentType1Selected = 'Documentation and Editing';
  var _currentType2Selected = 'Cleaning';
  var _currentType3Selected = 'Delivery/Pickup';

  String selectedCtg;
  String selectedType;

  @override
  void initState() {
    super.initState();
    print("Data: ${widget.jobPosting.category}");
    print("Data: ${widget.jobPosting.type}");
    jobTitleController = TextEditingController(text: widget.jobPosting.title);
    jobDescController = TextEditingController(text: widget.jobPosting.desc);
    jobRateController = TextEditingController(text: widget.jobPosting.rate);
    jobDateController = TextEditingController(text: widget.jobPosting.jobDate);

    selectedCtg = widget.jobPosting.category;
    _currentCtgSelected = selectedCtg;
    selectedType = widget.jobPosting.type;

    if (_currentCtgSelected == 'University Jobs') {
      _currentType1Selected = selectedType;
      selectedJobCtg = 'University Jobs';
    } else if (_currentCtgSelected == 'Chores') {
      _currentType2Selected = selectedType;
      selectedJobCtg = 'Chores';
    } else if (_currentCtgSelected == 'Errands') {
      _currentType3Selected = selectedType;
      selectedJobCtg = 'Errands';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<MyJobViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => MyJobViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Update Job'),
        body: Stack(
          children: [
            Container(
              height: screenHeight,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      color: bgColor,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            jobTitleController,
                            'Tap to enter title...',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'title',
                          ),
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      color: bgColor,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            jobDescController,
                            'Tap to enter description...',
                            6,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'description',
                          ),
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      color: bgColor,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 180,
                                child: Text(
                                  'Category:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Material(
                                  elevation: 0.8,
                                  child: Container(
                                    height: 45.0,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.0),
                                      //shadowColor: Color.fromRGBO(57, 57, 57, 5),
                                      color: Colors.white,
                                    ),
                                    child: DropdownButton<String>(
                                      underline: Container(),
                                      items: _jobCategory
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              Container(
                                                width: 164,
                                                child: Text(
                                                  dropDownStringItem,
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      icon: Transform.rotate(
                                          angle: 90 * pi / 180,
                                          child: Icon(Icons.chevron_right,
                                              color: Colors.black54)),
                                      onChanged: (String newCtgSelected) {
                                        setState(() {
                                          _currentCtgSelected = newCtgSelected;
                                          selectedJobCtg = _currentCtgSelected;
                                          selectedCtg = selectedJobCtg;

                                          if (_currentCtgSelected ==
                                              'University Jobs') {
                                            selectedType =
                                                _currentType1Selected;
                                          } else if (_currentCtgSelected ==
                                              'Chores') {
                                            selectedType =
                                                _currentType2Selected;
                                          } else if (_currentCtgSelected ==
                                              'Errands') {
                                            selectedType =
                                                _currentType3Selected;
                                          }
                                        });
                                      },
                                      value: _currentCtgSelected,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              Container(
                                width: 180,
                                child: Text(
                                  'Type:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Material(
                                  elevation: 0.8,
                                  child: Container(
                                      height: 45.0,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                        //shadowColor: Color.fromRGBO(57, 57, 57, 5),
                                        color: Colors.white,
                                      ),
                                      child: selectedJobCtg == 'University Jobs'
                                          ? DropdownButton<String>(
                                              underline: Container(),
                                              items: _univCtgType.map(
                                                  (String dropDownStringItem) {
                                                return DropdownMenuItem<String>(
                                                  value: dropDownStringItem,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10),
                                                      Container(
                                                        width: 164,
                                                        child: Text(
                                                          dropDownStringItem,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                              icon: Transform.rotate(
                                                  angle: 90 * pi / 180,
                                                  child: Icon(
                                                      Icons.chevron_right,
                                                      color: Colors.black54)),
                                              onChanged:
                                                  (String newTypeSelected) {
                                                setState(() {
                                                  _currentType1Selected =
                                                      newTypeSelected;
                                                  selectedType =
                                                      _currentType1Selected;
                                                });
                                              },
                                              value: _currentType1Selected,
                                            )
                                          : selectedJobCtg == 'Chores'
                                              ? DropdownButton<String>(
                                                  underline: Container(),
                                                  items: _chorCtgType.map(
                                                      (String
                                                          dropDownStringItem) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: dropDownStringItem,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 10),
                                                          Container(
                                                            width: 164,
                                                            child: Text(
                                                              dropDownStringItem,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                  icon: Transform.rotate(
                                                      angle: 90 * pi / 180,
                                                      child: Icon(
                                                          Icons.chevron_right,
                                                          color:
                                                              Colors.black54)),
                                                  onChanged:
                                                      (String newTypeSelected) {
                                                    setState(() {
                                                      _currentType2Selected =
                                                          newTypeSelected;
                                                      selectedType =
                                                          _currentType2Selected;
                                                    });
                                                  },
                                                  value: _currentType2Selected,
                                                )
                                              : DropdownButton<String>(
                                                  underline: Container(),
                                                  items: _erraCtgType.map(
                                                      (String
                                                          dropDownStringItem) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: dropDownStringItem,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 10),
                                                          Container(
                                                            width: 164,
                                                            child: Text(
                                                              dropDownStringItem,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                  icon: Transform.rotate(
                                                      angle: 90 * pi / 180,
                                                      child: Icon(
                                                          Icons.chevron_right,
                                                          color:
                                                              Colors.black54)),
                                                  onChanged:
                                                      (String newTypeSelected) {
                                                    setState(() {
                                                      _currentType3Selected =
                                                          newTypeSelected;
                                                      selectedType =
                                                          _currentType3Selected;
                                                    });
                                                  },
                                                  value: _currentType3Selected,
                                                )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      color: bgColor,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rate(RM):',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              Spacer(),
                              awesomeTextField(
                                jobRateController,
                                '00.00',
                                1,
                                1,
                                200,
                                TextInputType.number,
                                'job rate',
                              )
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              Text(
                                'Job Date:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              Spacer(),
                              awesomeTextField(
                                jobDateController,
                                'DD/MM/YYYY',
                                1,
                                1,
                                200,
                                TextInputType.datetime,
                                'job date',
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: transparentButton("Update Job", () async {
                        var newRate;
                        print(jobTitleController.text);
                        print(jobDescController.text);
                        print(selectedCtg);
                        print(selectedType);
                        print(jobRateController.text);

                        if (jobRateController.text != '') {
                          var rate = double.parse(jobRateController.text);
                          newRate = rate.toStringAsFixed(2);
                          print('double conversionnn');
                          print('new rate is = ' + newRate.toString());
                        }

                        print(jobDateController.text);
                        if (_formKey.currentState.validate()) {
                          model.updateJob(
                              id: widget.jobPosting.id,
                              title: jobTitleController.text,
                              desc: jobDescController.text,
                              category: selectedCtg,
                              type: selectedType,
                              rate: newRate,
                              jobDate: jobDateController.text);
                          await Future.delayed(Duration(seconds: 1));
                          awesomeToast('Job Updated!');
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          JobProviderHome(tab: 3)),
                                  (route) => false);
                        }
                      }, botttomBarColor, Colors.transparent, screenWidth - 30),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

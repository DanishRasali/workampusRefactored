import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobSeekerApp/jobSeekerHome.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/buttons.dart';
import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';

import 'job_viewmodel.dart';

class FilterJobView extends StatefulWidget {
  const FilterJobView({
    this.tab,
    this.ut1,
    this.ut2,
    this.ut3,
    this.ct1,
    this.ct2,
    this.ct3,
    this.et1,
    this.et2,
  });
  final int tab;

  // define and set for uni type
  final bool ut1;
  final bool ut2;
  final bool ut3;

  // define and set for chor type
  final bool ct1;
  final bool ct2;
  final bool ct3;

  // define and set for err type
  final bool et1;
  final bool et2;
  @override
  _FilterJobViewState createState() => _FilterJobViewState();
}

class _FilterJobViewState extends State<FilterJobView> {
  bool ut1;
  bool ut2;
  bool ut3;

  bool ct1;
  bool ct2;
  bool ct3;

  bool et1;
  bool et2;

  @override
  void initState() {
    super.initState();
    ut1 = widget.ut1 == null ? false : widget.ut1;
    ut2 = widget.ut2 == null ? false : widget.ut2;
    ut3 = widget.ut3 == null ? false : widget.ut3;

    ct1 = widget.ct1 == null ? false : widget.ct1;
    ct2 = widget.ct2 == null ? false : widget.ct2;
    ct3 = widget.ct3 == null ? false : widget.ct3;

    et1 = widget.et1 == null ? false : widget.et1;
    et2 = widget.et2 == null ? false : widget.et2;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ViewModelBuilder<JobViewModel>.reactive(
      viewModelBuilder: () => JobViewModel(),
      onModelReady: (model) => model.initialise(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Filter Job'),
        body: Container(
          height: screenHeight,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.00, top: 15, bottom: 4),
                  child: _titleContainer("University Jobs"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.00, bottom: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      filterChipWidget(
                        chipName: 'Documentation and Editing',
                        isSelected: ut1,
                        onSelected: (isSelected) {
                          setState(() {
                            ut1 = isSelected;
                          });
                        },
                      ),
                      filterChipWidget(
                        chipName: 'Tutoring',
                        isSelected: ut2,
                        onSelected: (isSelected) {
                          setState(() {
                            ut2 = isSelected;
                          });
                        },
                      ),
                      filterChipWidget(
                        chipName: 'Assiting',
                        isSelected: ut3,
                        onSelected: (isSelected) {
                          setState(() {
                            ut3 = isSelected;
                          });
                        },
                      ),
                    ],
                  )),
                ),
              ),
              awesomeDivider(0.8, dividerColor),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.00, top: 15, bottom: 4),
                  child: _titleContainer("Chores"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.00, bottom: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      filterChipWidget(
                        chipName: 'Cleaning',
                        isSelected: ct1,
                        onSelected: (isSelected) {
                          setState(() {
                            ct1 = isSelected;
                          });
                        },
                      ),
                      filterChipWidget(
                        chipName: 'Laundry',
                        isSelected: ct2,
                        onSelected: (isSelected) {
                          setState(() {
                            ct2 = isSelected;
                          });
                        },
                      ),
                      filterChipWidget(
                        chipName: 'General Helper',
                        isSelected: ct3,
                        onSelected: (isSelected) {
                          setState(() {
                            ct3 = isSelected;
                          });
                        },
                      ),
                    ],
                  )),
                ),
              ),
              awesomeDivider(0.8, dividerColor),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.00, top: 15, bottom: 4),
                  child: _titleContainer("Errands"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.00),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      filterChipWidget(
                        chipName: 'Delivery/Pickup',
                        isSelected: et1,
                        onSelected: (isSelected) {
                          setState(() {
                            et1 = isSelected;
                          });
                        },
                      ),
                      filterChipWidget(
                        chipName: 'Shopping',
                        isSelected: et2,
                        onSelected: (isSelected) {
                          setState(() {
                            et2 = isSelected;
                          });
                        },
                      ),
                    ],
                  )),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: transparentButton("Filter", () async {
                  print('UniType1 is ' + ut1.toString());
                  print('UniType2 is ' + ut2.toString());
                  print('UniType3 is ' + ut3.toString());

                  print('ChorType1 is ' + ct1.toString());
                  print('ChorType2 is ' + ct2.toString());
                  print('ChorType3 is ' + ct3.toString());

                  print('ErrType1 is ' + et1.toString());
                  print('ErrType2 is ' + et2.toString());

                  if (ut1 == false &&
                      ut2 == false &&
                      ut3 == false &&
                      ct1 == false &&
                      ct2 == false &&
                      ct3 == false &&
                      et1 == false &&
                      et2 == false) {
                    awesomeToast('Please select any job type');
                  } else {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => JobSeekerHome(
                          tab: 0,
                          ut1: ut1,
                          ut2: ut2,
                          ut3: ut3,
                          ct1: ct1,
                          ct2: ct2,
                          ct3: ct3,
                          et1: et1,
                          et2: et2,
                        ),
                      ),
                    );
                    awesomeToast('Jobs Filtered!');
                  }
                }, Color.fromRGBO(57, 57, 57, 25),
                    Color.fromRGBO(57, 57, 57, 25), screenWidth - 30,
                    textColor: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
  );
}

class filterChipWidget extends StatefulWidget {
  final String chipName;
  bool isSelected;
  var onSelected;

  filterChipWidget({this.chipName, this.isSelected, this.onSelected});

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: accentColor, fontSize: 16.0, fontWeight: FontWeight.bold),
      selected: widget.isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: widget.onSelected,
      selectedColor: Color.fromRGBO(255, 214, 209, 1),
    );
  }
}

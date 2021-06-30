// import 'package:dulang_new/services/food_data_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/offeredService.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/textField.dart';
import 'package:workampus/shared/buttons.dart';
import 'dart:math';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';

import '../../jobSeekerHome.dart';
import '../myService_viewmodel.dart';

class UpdateMyServiceView extends StatefulWidget {
  const UpdateMyServiceView({this.tab, this.offeredService});
  final OfferedService offeredService;
  final int tab;

  @override
  _UpdateMyServiceViewState createState() => _UpdateMyServiceViewState();
}

class _UpdateMyServiceViewState extends State<UpdateMyServiceView> {
  TextEditingController serviceTitleController = TextEditingController();
  TextEditingController serviceDescController = TextEditingController();
  TextEditingController serviceChargController = TextEditingController();
  TextEditingController serviceAvaiController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedServiceCtg = 'University Jobs';

  var _serviceCategory = ['University Jobs', 'Chores', 'Errands'];

  var _univCtgType = ['Documentation and Editing', 'Tutoring', 'Assiting'];
  var _chorCtgType = ['Cleaning', 'Laundry', 'General Helper'];
  var _erraCtgType = ['Delivery/Pickup', 'Shopping'];

  var _currentCtgSelected;
  var _currentType1Selected = 'Documentation and Editing';
  var _currentType2Selected = 'Cleaning';
  var _currentType3Selected = 'Delivery/Pickup';

  String selectedCtg;
  String selectedType;

  @override
  void initState() {
    super.initState();
    print("Data: ${widget.offeredService.category}");
    print("Data: ${widget.offeredService.type}");
    serviceTitleController =
        TextEditingController(text: widget.offeredService.title);
    serviceDescController =
        TextEditingController(text: widget.offeredService.desc);
    serviceChargController =
        TextEditingController(text: widget.offeredService.charges);
    serviceAvaiController =
        TextEditingController(text: widget.offeredService.availability);

    selectedCtg = widget.offeredService.category;
    _currentCtgSelected = selectedCtg;
    selectedType = widget.offeredService.type;

    if (_currentCtgSelected == 'University Jobs') {
      _currentType1Selected = selectedType;
      selectedServiceCtg = 'University Jobs';
    } else if (_currentCtgSelected == 'Chores') {
      _currentType2Selected = selectedType;
      selectedServiceCtg = 'Chores';
    } else if (_currentCtgSelected == 'Errands') {
      _currentType3Selected = selectedType;
      selectedServiceCtg = 'Errands';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<MyServiceViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => MyServiceViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Update Service'),
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
                            serviceTitleController,
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
                            serviceDescController,
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
                                      items: _serviceCategory
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
                                          selectedServiceCtg =
                                              _currentCtgSelected;
                                          selectedCtg = selectedServiceCtg;
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
                                      child: selectedServiceCtg ==
                                              'University Jobs'
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
                                          : selectedServiceCtg == 'Chores'
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
                                'Charges(RM):',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              Spacer(),
                              awesomeTextField(
                                serviceChargController,
                                '00.00',
                                1,
                                1,
                                200,
                                TextInputType.number,
                                'charges',
                              )
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              Text(
                                'Availability:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              Spacer(),
                              awesomeTextField(
                                serviceAvaiController,
                                'Tap to enter availability...',
                                1,
                                1,
                                200,
                                TextInputType.multiline,
                                'availability',
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
                      padding: const EdgeInsets.all(15),
                      child: transparentButton("Update Service", () async {
                        var newRate;
                        print(serviceTitleController.text);
                        print(serviceDescController.text);
                        print(selectedCtg);
                        print(selectedType);
                        print(serviceChargController.text);

                        if (serviceChargController.text != '') {
                          var rate = double.parse(serviceChargController.text);
                          newRate = rate.toStringAsFixed(2);
                          print('double conversionnn');
                          print('new rate is = ' + newRate.toString());
                        }

                        print(serviceAvaiController.text);
                        if (_formKey.currentState.validate()) {
                          model.updateService(
                              id: widget.offeredService.id,
                              title: serviceTitleController.text,
                              desc: serviceDescController.text,
                              category: selectedCtg,
                              type: selectedType,
                              charges: newRate,
                              availability: serviceAvaiController.text);
                          await Future.delayed(Duration(seconds: 1));
                          awesomeToast('Service Updated!');
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          JobSeekerHome(tab: 3)),
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

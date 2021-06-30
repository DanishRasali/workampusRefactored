import 'package:flutter/material.dart';
import 'package:workampus/shared/colors.dart';
import 'contractsTab/contracts_view.dart';
import 'jobsTab/job_view.dart';
import 'myServiceTab/myService_view.dart';
import 'paymentsTab/payment_view.dart';
import 'requestsTab/request_view.dart';

class JobSeekerHome extends StatefulWidget {
  final int tab;
  final int contractIndex;
  final bool ut1;
  final bool ut2;
  final bool ut3;
  final bool ct1;
  final bool ct2;
  final bool ct3;
  final bool et1;
  final bool et2;

  const JobSeekerHome({
    this.tab,
    this.contractIndex,
    this.ut1,
    this.ut2,
    this.ut3,
    this.ct1,
    this.ct2,
    this.ct3,
    this.et1,
    this.et2,
  });
  @override
  _JobSeekerHomeState createState() => _JobSeekerHomeState();
}

class _JobSeekerHomeState extends State<JobSeekerHome> {
  int currentTab = 0;
  Widget currentScreen = JobView();

  final List<Widget> screens = [
    JobView(),
    PaymentView(),
    ContractJSView(),
    MyServiceView(),
    RequestScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentTab = widget.tab;
    if (currentTab == 0) {
      currentScreen = JobView(
        ut1: widget.ut1,
        ut2: widget.ut2,
        ut3: widget.ut3,
        ct1: widget.ct1,
        ct2: widget.ct2,
        ct3: widget.ct3,
        et1: widget.et1,
        et2: widget.et2,
      );
    }
    if (currentTab == 1) {
      currentScreen = PaymentView();
    }
    if (currentTab == 2) {
      currentScreen = ContractJSView(initialIndex: widget.contractIndex);
    }
    if (currentTab == 3) {
      currentScreen = MyServiceView();
    }
    if (currentTab == 4) {
      currentScreen = RequestScreen();
    }
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      //Bottom AppBar
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: width / 5,
                    child: MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            currentScreen = JobView(
                              tab: currentTab,
                            );
                            currentTab = 0;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.search,
                              color: currentTab == 0
                                  ? accentColor
                                  : botttomBarColor),
                          FittedBox(
                            child: Text('Jobs',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: currentTab == 0
                                        ? accentColor
                                        : botttomBarColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width / 5,
                    child: MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            currentScreen = PaymentView(
                              tab: currentTab,
                            );
                            currentTab = 1;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.payments,
                              color: currentTab == 1
                                  ? accentColor
                                  : botttomBarColor),
                          FittedBox(
                            child: Text('Payments',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: currentTab == 1
                                        ? accentColor
                                        : botttomBarColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width / 5,
                    child: MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            currentScreen = ContractJSView(
                              tab: currentTab,
                            );
                            currentTab = 2;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.assignment_outlined,
                              color: currentTab == 2
                                  ? accentColor
                                  : botttomBarColor),
                          FittedBox(
                            child: Text('Contracts',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: currentTab == 2
                                        ? accentColor
                                        : botttomBarColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width / 5,
                    child: MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            currentScreen = MyServiceView(
                              tab: currentTab,
                            );
                            currentTab = 3;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.business_center,
                              color: currentTab == 3
                                  ? accentColor
                                  : botttomBarColor),
                          FittedBox(
                            child: Text('My Services',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: currentTab == 3
                                        ? accentColor
                                        : botttomBarColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width / 5,
                    child: MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            currentScreen = RequestScreen(
                              tab: currentTab,
                            );
                            currentTab = 4;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.archive,
                              color: currentTab == 4
                                  ? accentColor
                                  : botttomBarColor),
                          FittedBox(
                            child: Text('Requests',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: currentTab == 4
                                        ? accentColor
                                        : botttomBarColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

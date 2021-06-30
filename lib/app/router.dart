import 'package:flutter/material.dart';
import 'package:workampus/app/route_transitions.dart';
import 'package:workampus/screens/initialScreen/login_view.dart';
import 'package:workampus/screens/initialScreen/signup_view.dart';
import 'package:workampus/screens/initialScreen/splash_screen.dart';
import 'package:workampus/screens/jobProviderApp/jobProviderHome.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/contracts_view.dart';
import 'package:workampus/screens/jobSeekerApp/jobSeekerHome.dart';
import 'package:workampus/screens/jobSeekerApp/jobsTab/job_view.dart';
import 'package:workampus/screens/jobSeekerApp/myServiceTab/myService_view.dart';

const String SplashViewRoute = '/splash';
const String JobSeekerHomeViewRoute = '/jobSeekerhome';
const String JobProviderHomeViewRoute = '/jobProviderhome';
const String LoginViewRoute = '/login';
const String RegisterViewRoute = '/register';
const String JobViewRoute = '/job';
const String MyServiceViewRoute = '/nyService';
const String ContractJSViewRoute = '/contractJS';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashViewRoute:
      return ScaleRoute(page: Splash());
    case JobSeekerHomeViewRoute:
      return ScaleRoute(page: JobSeekerHome(tab: 0));
    case JobProviderHomeViewRoute:
      return ScaleRoute(page: JobProviderHome(tab: 0));
    case LoginViewRoute:
      return ScaleRoute(page: Login());
    case RegisterViewRoute:
      return SlideUpRoute(page: Signup());
    case JobViewRoute:
      return ScaleRoute(page: JobView());
    case MyServiceViewRoute:
      return ScaleRoute(page: MyServiceView());
    case ContractJSViewRoute:
      return ScaleRoute(page: ContractJSView(initialIndex: 0));
  }
  return null;
}

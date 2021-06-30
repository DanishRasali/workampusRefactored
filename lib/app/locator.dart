import 'package:get_it/get_it.dart';
import 'package:workampus/screens/initialScreen/login_viewmodel.dart';
import 'package:workampus/screens/initialScreen/signup_viewmodel.dart';
import 'package:workampus/screens/jobProviderApp/myJobTab/myJob_viewmodel.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/contract_viewmodel.dart';
import 'package:workampus/screens/jobSeekerApp/myServiceTab/myService_viewmodel.dart';
import 'package:workampus/screens/jobSeekerApp/paymentsTab/payment_viewmodel.dart';
import 'package:workampus/services/authentication_service.dart';
import 'package:workampus/services/contract/contract_firestore_service.dart';
import 'package:workampus/services/jobPosting/jobPosting_firestore_service.dart';
import 'package:workampus/services/navigation_service.dart';
import 'package:workampus/services/offeredService/offeredService_firestore_service.dart';
import 'package:workampus/services/payment/payment_firestore_service.dart';
import 'package:workampus/services/payment/payout_firestore_service.dart';
import 'package:workampus/services/rating/rating_firestore_service.dart';
import 'package:workampus/services/user/user_firestore_service.dart';

final GetIt locator = GetIt.instance;

void initializeLocator() {
  // Services
  // locator.registerLazySingleton(() => ImageSelector());
  // locator.registerLazySingleton(() => PushNotificationService());

  // app service
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());

  // firestore service
  locator.registerLazySingleton(() => UserFirestoreService());
  locator.registerLazySingleton(() => JobPostingFirestoreService());
  locator.registerLazySingleton(() => OfferedServiceFirestoreService());
  locator.registerLazySingleton(() => ContractFirestoreService());
  locator.registerLazySingleton(() => PaymentFirestoreService());
  locator.registerLazySingleton(() => RatingFirestoreService());
  locator.registerLazySingleton(() => PayoutFirestoreService());

  // ViewModels
  locator.registerLazySingleton(() => SignupViewModel());
  locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => MyServiceViewModel());
  locator.registerLazySingleton(() => MyJobViewModel());
  locator.registerLazySingleton(() => ContractViewModel());
  locator.registerLazySingleton(() => PaymentViewModel());

  //
}

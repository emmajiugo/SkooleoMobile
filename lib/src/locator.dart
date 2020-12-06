import 'package:get_it/get_it.dart';
import 'package:skooleo/src/helpers/navigation_helper.dart';
import 'package:skooleo/src/helpers/pref_helper.dart';
import 'package:skooleo/src/providers/authentication_provider.dart';
import 'package:skooleo/src/services/contact_service.dart';
import 'package:skooleo/src/services/invoice_service.dart';
import 'package:skooleo/src/services/payment_service.dart';
import 'package:skooleo/src/services/school_service.dart';
import 'package:skooleo/src/services/user_service.dart';

final locator = GetIt.instance;

setupLocator() {
  // Providers
  locator.registerSingleton<AuthenticationProvider>(AuthenticationProvider());

  // Services
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<SchoolService>(() => SchoolService());
  locator.registerLazySingleton<InvoiceService>(() => InvoiceService());
  locator.registerLazySingleton<ContactService>(() => ContactService());
  locator.registerLazySingleton<PaymentService>(() => PaymentService());

  // Helpers
  locator.registerLazySingleton<PrefHelper>(() => PrefHelper());
  locator.registerLazySingleton<NavigationHelper>(() => NavigationHelper());
}

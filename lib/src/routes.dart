import 'package:flutter/material.dart';
import 'package:skooleo/src/screens/add_student_screen.dart';
import 'package:skooleo/src/screens/change_password_screen.dart';
import 'package:skooleo/src/screens/coming_soon_screen.dart';
import 'package:skooleo/src/screens/contact_screen.dart';
import 'package:skooleo/src/screens/edit_profile_screen.dart';
import 'package:skooleo/src/screens/forgot_password_screen.dart';
import 'package:skooleo/src/screens/login_screen.dart';
import 'package:skooleo/src/screens/nav_screen.dart';
import 'package:skooleo/src/screens/register_screen.dart';
import 'package:skooleo/src/screens/school_fee_screen.dart';
import 'package:skooleo/src/screens/school_search_screen.dart';
import 'package:skooleo/src/screens/single_invoice_screen.dart';
import 'package:skooleo/src/screens/splash_screen.dart';
import 'package:skooleo/src/screens/webview_screen.dart';
import 'package:skooleo/src/screens/welcome_screen.dart';

const SPLASH_SCREEN = 'splash_screen';
const WELCOME_SCREEN = 'welcome_screen';
const LOGIN_SCREEN = 'login_screen';
const REGISTER_SCREEN = 'register_screen';
const NAV_SCREEN = 'nav_screen';
const SEARCH_SCREEN = 'search_screen';
const SCHOOL_SEARCH_SCREEN = 'school_search_screen';
const SCHOOL_FEE_SCREEN = 'school_fee_screen';
const ADD_STUDENT_SCREEN = 'add_student_screen';
const PAY_FEE_SCREEN = 'pay_fee_screen';
const COMING_SOON_SCREEN = 'coming_soon_screen';
const SINGLE_INVOICE_SCREEN = 'single_invoice_screen';
const CONTACT_SCREEN = 'contact_screen';
const EDIT_PROFILE_SCREEN = 'edit_profile_screen';
const WEB_VIEW_SCREEN = 'web_view_screen';
const FORGOT_PASSWORD_SCREEN = 'forgot_password_screen';
const CHANGE_PASSWORD_SCREEN = 'change_password_screen';

Route<dynamic> generatedRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SPLASH_SCREEN:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case WELCOME_SCREEN:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
    case LOGIN_SCREEN:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case REGISTER_SCREEN:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case FORGOT_PASSWORD_SCREEN:
      return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
    case NAV_SCREEN:
      return MaterialPageRoute(builder: (context) => NavScreen());
    case COMING_SOON_SCREEN:
      return MaterialPageRoute(builder: (context) => ComingSoonScreen());
    case SINGLE_INVOICE_SCREEN:
      return MaterialPageRoute(
        builder: (context) => SingleInvoiceScreen(
          reference: settings.arguments,
        ),
      );
    case WEB_VIEW_SCREEN:
      return MaterialPageRoute(
        builder: (context) => WebViewScreen(
          url: settings.arguments,
        ),
      );
    case SCHOOL_SEARCH_SCREEN:
      return MaterialPageRoute(builder: (context) => SchoolSearchScreen());
    case SCHOOL_FEE_SCREEN:
      return MaterialPageRoute(
        builder: (context) => SchoolFeeScreen(
          schoolId: settings.arguments,
        ),
      );
    case ADD_STUDENT_SCREEN:
      return MaterialPageRoute(
          builder: (context) => AddStudentScreen(
                studentFee: settings.arguments,
              ));
    case CONTACT_SCREEN:
      return MaterialPageRoute(builder: (context) => ContactScreen());
    case EDIT_PROFILE_SCREEN:
      return MaterialPageRoute(builder: (context) => EditProfileScreen());
    case CHANGE_PASSWORD_SCREEN:
      return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Oops!... ${settings.name} was not found :('),
          ),
        ),
      );
  }
}

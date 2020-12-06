import 'package:flutter/foundation.dart';
import 'package:skooleo/src/helpers/pref_helper.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/services/user_service.dart';

enum AuthState { INITIALIZING, AUTHENTICATED, UNAUTHENTICATED }

class AuthenticationProvider extends ChangeNotifier {
  AuthState _authState = AuthState.INITIALIZING;
  AuthState get authState => _authState;

  AuthenticationProvider() {
    checkAuth();
  }

  set _updateAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }

  void checkAuth() async {
    await Future.delayed(Duration(seconds: 2));
    _updateAuthState = await locator<PrefHelper>().getToken() != null
        ? AuthState.AUTHENTICATED
        : AuthState.UNAUTHENTICATED;
  }

  void logout() {
    locator<UserService>().logout();
  }
}

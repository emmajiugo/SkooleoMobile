import 'package:dio/dio.dart';
import 'package:skooleo/src/helpers/ExceptionHelper.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/models/login.dart';
import 'package:skooleo/src/providers/base_provider.dart';
import 'package:skooleo/src/services/user_service.dart';

class LoginProvider extends BaseProvider {
  Future<bool> login(Login login) async {
    isLoading = true;
    error = null;
    try {
      await locator<UserService>().login(login);
      isLoading = false;
      return true;
    } on DioError catch (e) {
      isLoading = false;
      if (e.type == DioErrorType.RESPONSE) {
        switch (e?.response?.statusCode) {
          case 401:
            error = ExceptionHelper('Invalid username and password');
            break;
          case 422:
            error = ExceptionHelper(
                (e?.response?.data as Map).values.toList()[0][0].toString());
            break;
          default:
            error = ExceptionHelper('An unexpected error occurred');
            break;
        }
      } else {
        error = ExceptionHelper(e.message);
      }
      return false;
    }
  }
}

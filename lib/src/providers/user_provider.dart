import 'package:dio/dio.dart';
import 'package:skooleo/src/helpers/ExceptionHelper.dart';
import 'package:skooleo/src/providers/base_provider.dart';
import 'package:skooleo/src/services/user_service.dart';

import '../locator.dart';

class UserProvider extends BaseProvider {
  Future<bool> updateProfile(String fullName, String phoneNumber) async {
    isLoading = true;
    error = null;
    try {
      await locator<UserService>().updateProfile(fullName, phoneNumber);
      isLoading = false;
      return true;
    } on DioError catch (e) {
      error = ExceptionHelper(e.message);
      isLoading = false;
      return false;
    }
  }
}

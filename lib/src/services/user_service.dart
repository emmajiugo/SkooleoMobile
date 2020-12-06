import 'package:dio/dio.dart';
import 'package:skooleo/src/helpers/navigation_helper.dart';
import 'package:skooleo/src/helpers/pref_helper.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/models/login.dart';
import 'package:skooleo/src/models/register.dart';
import 'package:skooleo/src/models/user_profile.dart';
import 'package:skooleo/src/services/config.dart';

import '../routes.dart';

class UserService {
  final _prefService = locator<PrefHelper>();
  final _navigationHelper = locator<NavigationHelper>();

  Future<void> login(Login login) async {
    Response response = await dio.post('/login', data: login.toJson());
    _prefService.saveToken(response.data['token']);
  }

  Future<void> refreshToken() async {
    Response response = await dio.post('/token/refresh');
    _prefService.saveToken(response.data['token']);
  }

  Future<void> register(Register register) async {
    await dio.post('/register', data: register.toJson());
    await login(Login(register.email, register.password));
  }

  Future<Map<String, dynamic>> forgotPassword(String username) async {
    Response response =
        await dio.post('/password/forgot', data: {'email_or_phone': username});
    return response.data;
  }

  Future<Map<String, dynamic>> changePassword(
      String newPassword, String confirmNewPassword) async {
    Map<String, String> data = {
      'new_password': newPassword,
      'confirm_new_password': confirmNewPassword
    };
    Response response = await dio.post('/password/change', data: data);
    return response.data;
  }

  Future<void> logout() async {
    // await dio.get('/logout');
    _prefService.clearToken();
    _navigationHelper.pushNamedAndRemoveUntil(WELCOME_SCREEN);
  }

  Future<UserProfile> getProfile() async {
    Response response = await dio.get('/profile');
    return UserProfile.fromJson(response.data['user']);
  }

  Future<Map<String, dynamic>> updateProfile(
      String fullName, String phoneNumber) async {
    Map<String, String> data = {'fullname': fullName, 'phone': phoneNumber};
    Response response = await dio.post('/profile/update', data: data);
    return response.data;
  }
}

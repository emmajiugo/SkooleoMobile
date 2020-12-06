import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skooleo/src/constants.dart';

class PrefHelper {
  SharedPreferences _sharedPreferences;
  FlutterSecureStorage _flutterSecureStorage;

  PrefHelper() {
    this._flutterSecureStorage = FlutterSecureStorage();
    setUp();
  }

  void setUp() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveToken(String token) {
    _flutterSecureStorage.write(key: ACCESS_TOKEN, value: token);
  }

  Future<String> getToken() async {
    return await _flutterSecureStorage.read(key: ACCESS_TOKEN);
  }

  void clearToken() {
    _sharedPreferences.clear();
    _flutterSecureStorage.delete(key: ACCESS_TOKEN);
  }
}

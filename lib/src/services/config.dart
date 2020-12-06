import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skooleo/src/constants.dart';
import 'package:skooleo/src/helpers/ExceptionHelper.dart';
import 'package:skooleo/src/helpers/pref_helper.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/services/user_service.dart';

BaseOptions _options = BaseOptions(
  baseUrl: BASE_URL,
  contentType: 'application/json',
);

class CustomInterceptor implements InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    String accessToken = await locator<PrefHelper>().getToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return options;
  }

  @override
  Future onResponse(Response response) async => response;

  @override
  Future onError(DioError error) async {
    String accessToken = await locator<PrefHelper>().getToken();
    switch (error.type) {
      case DioErrorType.RESPONSE:
        if (accessToken != null && error.response?.statusCode == 401) {
          Fluttertoast.showToast(
              msg: 'Session expired. Please log in again',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM);
          locator<UserService>().logout();
        }
        return error;
      case DioErrorType.SEND_TIMEOUT:
        return ExceptionHelper('Connection timeout with API server');
      case DioErrorType.CONNECT_TIMEOUT:
        return ExceptionHelper('Connection timeout with API server');
      case DioErrorType.RECEIVE_TIMEOUT:
        return ExceptionHelper('Receive timeout in connection with API server');
      case DioErrorType.CANCEL:
        return ExceptionHelper('Request to API server was cancelled');
      case DioErrorType.DEFAULT:
        return ExceptionHelper(
            'Connection to API server failed due to internet connection');
    }
  }
}

Dio dio = Dio(_options)
  ..interceptors.addAll(
    [
      CustomInterceptor(),
      LogInterceptor(),
    ],
  );

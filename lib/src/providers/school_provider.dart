import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skooleo/src/helpers/ExceptionHelper.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/models/school.dart';
import 'package:skooleo/src/models/school_fee.dart';
import 'package:skooleo/src/providers/base_provider.dart';
import 'package:skooleo/src/services/school_service.dart';

class SchoolProvider extends BaseProvider {
  SchoolFee _schoolFee;
  SchoolFee get schoolFee => _schoolFee;
  void setSchoolFee(SchoolFee schoolFee) {
    _schoolFee = schoolFee;
    notifyListeners();
  }

  Future<List<School>> searchSchools(String query) async {
    isLoading = true;
    error = null;
    try {
      return await locator<SchoolService>().getSchools(query);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return null;
    }
  }

  Future<bool> getSchoolFee(String schoolId, String feeType, String section,
      String session, String term, String className) async {
    isLoading = true;
    error = null;
    try {
      _schoolFee = await locator<SchoolService>()
          .getSchoolFee(schoolId, feeType, section, session, term, className);
      isLoading = false;
      return true;
    } on DioError catch (e) {
      if (e?.response?.statusCode == 404) {
        error = ExceptionHelper(e.response.data['message']);
      } else {
        error = ExceptionHelper(e.message);
      }
      isLoading = false;
      return false;
    }
  }
}

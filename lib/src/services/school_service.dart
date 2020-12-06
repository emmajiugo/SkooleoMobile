import 'package:dio/dio.dart';
import 'package:skooleo/src/models/school.dart';
import 'package:skooleo/src/models/school_detail.dart';
import 'package:skooleo/src/models/school_fee.dart';
import 'package:skooleo/src/services/config.dart';

class SchoolService {
  Future<List<School>> getSchools(String schoolName) async {
    Response response =
        await dio.get('/schools', queryParameters: {'school': schoolName});
    return (response.data['data'] as List)
        .map((school) => School.fromJson(school))
        .toList();
  }

  Future<SchoolDetail> getSingleSchool(String schoolId) async {
    Response response =
        await dio.post('/school/feetype', data: {'schoolId': schoolId});
    return SchoolDetail.fromJson(response.data['data']);
  }

  Future<Map<String, dynamic>> getStoreLink() async {
    Response response = await dio.get('/store');
    return response.data;
  }

  Future<SchoolFee> getSchoolFee(String schoolId, String feeType,
      String section, String session, String term, String className) async {
    Map<String, String> data = {
      'school_id': schoolId,
      'feetype': feeType,
      'section': section,
      'session': session,
      'term': term,
      'class': className
    };
    Response response = await dio.post('/school/fees', data: data);
    return SchoolFee.fromJson(response.data['data']);
  }
}

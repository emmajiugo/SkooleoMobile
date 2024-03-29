import 'package:dio/dio.dart';
import 'package:skooleo/src/models/contact.dart';

import 'config.dart';

class ContactService {
  Future<Contact> getContactDetails() async {
    Response response = await dio.get('/web-settings');
    return Contact.fromJson(response.data);
  }

  Future<String> getLiveChatLink() async {
    Response response = await dio.get('/live-chat');
    return response.data['data'];
  }
}

import 'package:dio/dio.dart';
import 'package:skooleo/src/helpers/ExceptionHelper.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/models/contact.dart';
import 'package:skooleo/src/providers/base_provider.dart';
import 'package:skooleo/src/services/contact_service.dart';

class ContactProvider extends BaseProvider {
  Contact _contact;
  Contact get contact => _contact;

  set contact(Contact contact) {
    _contact = contact;
    notifyListeners();
  }

  Future<void> getContactDetails() async {
    isLoading = true;
    error = null;
    try {
      contact = await locator<ContactService>().getContactDetails();
      isLoading = false;
    } on DioError catch (e) {
      error = ExceptionHelper(e.message);
      isLoading = false;
    }
  }
}

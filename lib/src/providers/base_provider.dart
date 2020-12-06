import 'package:flutter/foundation.dart';
import 'package:skooleo/src/helpers/ExceptionHelper.dart';

class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  ExceptionHelper _error;
  ExceptionHelper get error => _error;
  set error(ExceptionHelper error) {
    _error = error;
    notifyListeners();
  }
}

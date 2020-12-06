import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skooleo/src/helpers/ExceptionHelper.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/models/invoice.dart';
import 'package:skooleo/src/models/single_invoice.dart';
import 'package:skooleo/src/providers/base_provider.dart';
import 'package:skooleo/src/services/invoice_service.dart';

class InvoiceProvider extends BaseProvider {
  Future<List<Invoice>> getInvoices() async {
    try {
      return await locator<InvoiceService>().getAllInvoice();
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return null;
    }
  }

  SingleInvoice _invoice;
  SingleInvoice get invoice => _invoice;
  void _setInvoice(SingleInvoice invoice) {
    _invoice = invoice;
    notifyListeners();
  }

  Future<void> getSingleInvoice(String reference) async {
    isLoading = true;
    error = null;
    try {
      _setInvoice(await locator<InvoiceService>().getSingleInvoice(reference));
      isLoading = false;
    } on DioError catch (e) {
      error = ExceptionHelper(e.message);
      isLoading = false;
    }
  }

  String _invoiceId;
  String get invoiceId => _invoiceId;
  set invoiceId(String invoiceId) {
    _invoiceId = invoiceId;
    notifyListeners();
  }

  Future<bool> createInvoice(
      String section,
      String schoolId,
      String feeSetupId,
      String amount,
      String feeType,
      String session,
      String term,
      String studentClass,
      String studentName) async {
    isLoading = true;
    error = null;
    try {
      invoiceId = await locator<InvoiceService>().createInvoice(
          section,
          schoolId,
          feeSetupId,
          amount,
          feeType,
          session,
          term,
          studentClass,
          studentName);
      isLoading = false;
      return true;
    } on DioError catch (e) {
      print(e.message);
      error = ExceptionHelper(e.message);
      isLoading = false;
      return false;
    }
  }
}

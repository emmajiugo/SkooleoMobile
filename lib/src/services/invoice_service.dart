import 'package:dio/dio.dart';
import 'package:skooleo/src/models/invoice.dart';
import 'package:skooleo/src/models/single_invoice.dart';
import 'package:skooleo/src/services/config.dart';

class InvoiceService {
  Future<List<Invoice>> getAllInvoice() async {
    Response response = await dio.get('/invoices');
    return (response.data['data'] as List)
        .map((invoice) => Invoice.fromJson(invoice))
        .toList();
  }

  Future<SingleInvoice> getSingleInvoice(String reference) async {
    Response response = await dio.get('/invoice/$reference');
    return SingleInvoice.fromJson(response.data['data']);
  }

  Future<String> createInvoice(
      String section,
      String schoolId,
      String feeSetupId,
      String amount,
      String feeType,
      String session,
      String term,
      String studentClass,
      String studentName) async {
    Map<String, String> data = {
      'section': section,
      'schoolid': schoolId,
      'feesetupid': feeSetupId,
      'amount': amount,
      'feetype': feeType,
      'session': session,
      'term': term,
      'studentclass': studentClass,
      'studentname': studentName
    };
    Response response = await dio.post('/invoices', data: data);
    return response.data['data']['invoice_reference'];
  }
}

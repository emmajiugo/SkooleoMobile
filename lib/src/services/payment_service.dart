import 'package:dio/dio.dart';
import 'package:skooleo/src/models/payment_link.dart';

import 'config.dart';

class PaymentService {
  Future<PaymentLink> paySingle(int invoiceId) async {
    Map<String, int> data = {'invoice_id': invoiceId};
    Response response = await dio.post('/payments/single', data: data);
    return PaymentLink.fromJson(response.data);
  }

  Future<PaymentLink> payBulk() async {
    Response response = await dio.get('/payments/bulk');
    print(response.data);
    return PaymentLink.fromJson(response.data);
  }
}

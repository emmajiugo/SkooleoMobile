import 'package:intl/intl.dart';

String formatAmount(dynamic amount) {
  double balance = double.tryParse(amount);
  final formatCurrency =
      NumberFormat.simpleCurrency(decimalDigits: 2, locale: 'en_NG', name: '₦');
  return formatCurrency.format(balance);
}

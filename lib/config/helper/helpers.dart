import 'package:intl/intl.dart';

class Helpers {
  static String humanNumber(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      locale: 'en-US',
      symbol: '',
    ).format(number);
    return formattedNumber;
  }

  static DateTime defaultDatetime() => DateTime(1970, 1, 1);
}

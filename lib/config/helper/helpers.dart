import 'package:intl/intl.dart';

class Helpers {
  static String humanNumber(double number) {
    final formattedNumber = NumberFormat.currency(
      decimalDigits: 1,
      locale: 'en_US',
      symbol: '',
    ).format(number);

    return formattedNumber;
  }
}

//^ Adaptacion del paquete intl

import 'package:intl/intl.dart';

class IntlPlugin {

  static String compactCurrency({required double number, String? locale, String? name, String? symbol, int? decimalDigits}){

    final formatted = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      locale: locale,
      name: name,
      symbol: symbol,
    ).format(number);

    return formatted;
  }

}
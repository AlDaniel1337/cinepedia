import 'package:intl/intl.dart';
import 'package:cinepedia/src/config/plugins/intl.adapter.dart';

class HumanFormats {

  /// Volver numero a un string facil de leer para las personas, [7.256 -> 7.2]
  static String humanReadbleNumber({required double number, int decimalDigits = 1 }){

    return IntlPlugin.compactCurrency(
      number: number,
      decimalDigits: decimalDigits, 
      locale: 'en',
      symbol: ''
    );

  }

  /// Volver numero a un numero con letras [1,000 -> 1K]
  static String number({required double number, int decimalDigits = 1 }){

    return NumberFormat.compactCurrency(
      decimalDigits: decimalDigits, 
      locale: 'en',
      symbol: ''
    ).format(number);
    
  }

}

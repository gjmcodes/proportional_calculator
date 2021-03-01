import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class CurrencyServices{
  static String currencySymbol = "";
  static String decimalSeparator = "";
  static String thousandsSeparator = "";
  static NumberFormat _currencyFormat;

  static void setCurrencyFormat(BuildContext context){
    final String platformLocale = Platform.localeName;

    _currencyFormat = NumberFormat.simpleCurrency(locale: platformLocale);
    currencySymbol = _currencyFormat.currencySymbol;
    decimalSeparator = _currencyFormat.symbols.DECIMAL_SEP;
    thousandsSeparator = _currencyFormat.symbols.GROUP_SEP;
  }

  static String getFormattedValue(double number){
    return _currencyFormat.format(number);
  }

  static MoneyMaskedTextController getMoneyMaskedTextController(){
    return MoneyMaskedTextController(
        decimalSeparator: CurrencyServices.decimalSeparator,
        thousandSeparator: CurrencyServices.thousandsSeparator,
        leftSymbol: CurrencyServices.currencySymbol);
  }

  static MoneyMaskedTextController getFormattedTextController(){
    return MoneyMaskedTextController(
        decimalSeparator: CurrencyServices.decimalSeparator,
        thousandSeparator: CurrencyServices.thousandsSeparator);
  }
}
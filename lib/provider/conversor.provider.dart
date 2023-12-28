import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

class ConversorProvider with ChangeNotifier {
  String _dropdownFirst = 'dolar';
  String _dropdownSecond = 'bolivar';
  double _valueFirst = 0;
  String _valueSecond = "0";

  String get dropdownFirst => _dropdownFirst;
  String get dropdownSecond => _dropdownSecond;
  double get valueFirst => _valueFirst;
  String get valueSecond => _valueSecond;

  set dropdownFirst(String value) {
    _dropdownFirst = value;
    notifyListeners();
  }

  set dropdownSecond(String value) {
    _dropdownSecond = value;
    notifyListeners();
  }

  set valueFirst(double value) {
    _valueFirst = value;
    notifyListeners();
  }

  set valueSecond(String value) {
    _valueSecond = value;
    notifyListeners();
  }

  void swap() {
    final String temp = _dropdownFirst;
    _dropdownFirst = _dropdownSecond;
    _dropdownSecond = temp;
    notifyListeners();
  }

  void convert({String dolar = "", String euro = ""}) {
    switch (dropdownFirst) {
      case "dolar":
        switch (dropdownSecond) {
          case "dolar":
            valueSecond = formatOut(valueFirst, "\$");
            break;
          case "bolivar":
            valueSecond = formatOut(valueFirst * double.parse(dolar), "Bs.");
            break;
          case "euro":
            valueSecond = formatOut(
              valueFirst * double.parse(dolar) / double.parse(euro),
              "€",
            );
            break;
        }
        break;
      case "bolivar":
        switch (dropdownSecond) {
          case "dolar":
            valueSecond = formatOut(valueFirst / double.parse(dolar), "\$");
            break;
          case "bolivar":
            valueSecond = formatOut(valueFirst, "Bs.");
            break;
          case "euro":
            valueSecond = formatOut(
              valueFirst / double.parse(euro),
              "€",
            );
            break;
        }
        break;
      case "euro":
        switch (dropdownSecond) {
          case "dolar":
            valueSecond = formatOut(
              valueFirst * double.parse(euro) / double.parse(dolar),
              "\$",
            );
            break;
          case "bolivar":
            valueSecond = formatOut(valueFirst * double.parse(euro), "Bs.");
            break;
          case "euro":
            valueSecond = formatOut(valueFirst, "€");
            break;
        }
        break;
    }
  }

  String formatOut(double value, String currency) {
    MoneyFormatter out = MoneyFormatter(
      amount: value,
      settings: MoneyFormatterSettings(
        symbol: currency,
      ),
    );
    return out.output.symbolOnLeft;
  }
}

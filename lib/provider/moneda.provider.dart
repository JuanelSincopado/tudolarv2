import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tudolar/helpers/bvc.dart';

class MonedaProvider with ChangeNotifier {
  MonedaProvider.instance() {
    getCurrency();
  }

  bool _loading = false;
  String _dolar = '0.00';
  String _euro = '0.00';
  final controller = RefreshController(initialRefresh: false);

  bool get loading => _loading;
  String get dolar => _dolar;
  String get euro => _euro;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set dolar(String value) {
    _dolar = value;
    notifyListeners();
  }

  set euro(String value) {
    _euro = value;
    notifyListeners();
  }

  void getCurrency({loadingParams = true}) async {
    loading = loadingParams;

    final String dolar = await BCV.getRates(currencyCode: 'dolar');
    final String euro = await BCV.getRates(currencyCode: 'euro');

    this.dolar = dolar;
    this.euro = euro;

    loading = false;
  }

  Future<void> onRefresh() async {
    getCurrency(loadingParams: false);
    controller.refreshCompleted();
  }
}

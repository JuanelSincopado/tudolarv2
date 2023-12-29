import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tudolar/helpers/bvc.dart';

class MonedaProvider with ChangeNotifier {
  MonedaProvider.instance() {
    getCurrency();
  }

  bool _loading = false;
  String _dolar = '0.00';
  String _euro = '0.00';
  DateTime _date = DateTime.now();
  final controller = RefreshController(initialRefresh: false);
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  bool isOnline = false;
  bool showPrincipal = false;

  bool get loading => _loading;
  String get dolar => _dolar;
  String get euro => _euro;
  DateTime get date => _date;
  ConnectivityResult get connectivity => connectivityResult;
  bool get online => isOnline;
  bool get principal => showPrincipal;

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

  set date(DateTime value) {
    _date = value;
    notifyListeners();
  }

  set connectivity(ConnectivityResult value) {
    connectivityResult = value;
    notifyListeners();
  }

  set online(bool value) {
    isOnline = value;
    notifyListeners();
  }

  set principal(bool value) {
    showPrincipal = value;
    notifyListeners();
  }

  Future<void> getCurrency({loadingParams = true}) async {
    loading = loadingParams;

    final localBox = await Hive.openBox('currency');

    await checkInternet();

    if (isOnline) {
      final String dolar = await BCV.getRates(currencyCode: 'dolar');
      final String euro = await BCV.getRates(currencyCode: 'euro');

      this.dolar = dolar;
      this.euro = euro;
      date = DateTime.now();

      localBox.put('dolar', dolar);
      localBox.put('euro', euro);
      localBox.put('date', date.toString());

      AlertController.show(
        "Actualizado",
        "Se ha actualizado la información",
        TypeAlert.success,
      );
    } else {
      if (localBox.get('dolar') != null) {
        dolar = localBox.get('dolar');
      }

      if (localBox.get('euro') != null) {
        euro = localBox.get('euro');
      }

      if (localBox.get('date') != null) {
        date = DateTime.parse(localBox.get('date'));
      }

      if (dolar == '0.00' && euro == '0.00') {
        AlertController.show(
          "Sin conexión",
          "No se ha podido cargar la información",
          TypeAlert.error,
        );

        return;
      }

      AlertController.show(
        "Sin conexión",
        "Se ha cargado la última información guardada",
        TypeAlert.error,
      );
    }

    loading = false;
  }

  Future<void> checkInternet() async {
    connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isOnline = true;
    } else {
      isOnline = false;
    }
  }

  void onRefresh() async {
    await getCurrency(loadingParams: false);
    controller.refreshCompleted();
  }
}

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class BCVWebSite {
  static Future<dynamic> getRates({required currencyCode}) async {
    final response = await http.get(Uri.parse('https://www.bcv.org.ve/'));

    if (response.statusCode == 200) {
      final $ = html.parse(response.body);

      final List exchangeRates = [
        $.querySelector('#euro')!.text.split(' '),
        $.querySelector('#yuan')!.text.split(' '),
        $.querySelector('#lira')!.text.split(' '),
        $.querySelector('#rublo')!.text.split(' '),
        $.querySelector('#dolar')!.text.split(' ')
      ];

      final double euro = double.parse(exchangeRates[0][1]);
      final double yuan = double.parse(exchangeRates[1][1]);
      final double lira = double.parse(exchangeRates[2][1]);
      final double rublo = double.parse(exchangeRates[3][1]);
      final double dolar = double.parse(exchangeRates[4][1]);

      final Map<String, dynamic> rates = {
        exchangeRates[0][0]: euro.toStringAsFixed(2),
        exchangeRates[1][0]: yuan.toStringAsFixed(2),
        exchangeRates[2][0]: lira.toStringAsFixed(2),
        exchangeRates[3][0]: rublo.toStringAsFixed(2),
        exchangeRates[4][0]: dolar.toStringAsFixed(2)
      };

      if (rates.containsKey(currencyCode)) {
        return rates[currencyCode];
      } else {
        return rates;
      }
    }
  }

  @override
  String toString() {
    return 'La clase BCVWebSite() tiene un constructor sin parámetros. Simplemente creará un objeto vacío de la clase BCVWebSite, Junto al metodo para obtener el Tipo de Cambio.';
  }
}

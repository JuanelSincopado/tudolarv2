import 'package:html/parser.dart' as html;
import 'dart:convert';
import 'dart:io';

class BCV {
  static Future<dynamic> getRates({required currencyCode}) async {
    final client = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    final response = await client
        .getUrl(Uri.parse('https://www.bcv.org.ve/'))
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) =>
            response.transform(utf8.decoder).join());

    // final response = await http.get(Uri.parse('https://www.bcv.org.ve/'));

    // print(response);

    final $ = html.parse(response);

    final List exchangeRates = [
      $.querySelector('#euro')!.text,
      $.querySelector('#dolar')!.text
    ];

    final String cleanEuroData = exchangeRates[0].trim().split(' ').last;
    final cleanDolarData = exchangeRates[1].trim().split(' ').last;

    final double euro = double.parse(cleanEuroData.replaceAll(',', '.'));
    final double dolar = double.parse(cleanDolarData.replaceAll(',', '.'));

    final Map<String, dynamic> rates = {
      "euro": euro.toStringAsFixed(2),
      "dolar": dolar.toStringAsFixed(2)
    };

    if (rates.containsKey(currencyCode)) {
      return rates[currencyCode];
    } else {
      return rates;
    }
  }
}

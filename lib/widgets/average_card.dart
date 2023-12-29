import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tudolar/helpers/colors.dart';
import 'package:tudolar/provider/moneda.provider.dart';

class AverageCard extends StatelessWidget {
  const AverageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final monedaProvider = Provider.of<MonedaProvider>(context);
    final dolar = monedaProvider.dolar;
    final euro = monedaProvider.euro;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Promedio ',
                style: TextStyle(
                  fontSize: 25,
                  color: AppColors.letterDark,
                ),
              ),
              Text(
                'B',
                style: TextStyle(
                  fontSize: 25,
                  color: AppColors.yellow,
                ),
              ),
              Text(
                'C',
                style: TextStyle(
                  fontSize: 25,
                  color: AppColors.primary,
                ),
              ),
              Text(
                'V',
                style: TextStyle(
                  fontSize: 25,
                  color: AppColors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CurrencyValue(
            currency: "\$",
            value: dolar,
            color: AppColors.letterDark,
          ),
          const SizedBox(height: 10),
          CurrencyValue(
            currency: "€",
            value: euro,
            color: AppColors.letterDark,
          ),
          const SizedBox(height: 10),
          if (!monedaProvider.isOnline)
            const Icon(
              Icons.wifi_off,
              color: AppColors.red,
            ),
          const SizedBox(height: 10),
          Text(
            "Actualizado el ${monedaProvider.date.day}/${monedaProvider.date.month}/${monedaProvider.date.year} ${monedaProvider.date.hour}:${monedaProvider.date.minute}",
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.letterDark,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CurrencyValue extends StatelessWidget {
  const CurrencyValue(
      {super.key,
      required this.value,
      required this.currency,
      required this.color});

  final String value;
  final String currency;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Copiado al portapapeles",
              style: TextStyle(color: AppColors.letterDark),
            ),
          ),
        );
      },
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          Text(
            "${currency}1",
            style: TextStyle(
              fontSize: 25,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            " = Bs. $value",
            style: TextStyle(
              fontSize: 25,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

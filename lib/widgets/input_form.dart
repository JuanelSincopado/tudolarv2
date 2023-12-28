import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tudolar/helpers/colors.dart';
import 'package:tudolar/provider/conversor.provider.dart';
import 'package:tudolar/provider/moneda.provider.dart';

class InputForm extends StatelessWidget {
  const InputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final conversorprovider = Provider.of<ConversorProvider>(context);
    final monedaProvider = Provider.of<MonedaProvider>(context);
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[0-9.]')), // Permitir solo números y punto
      ],
      onChanged: (value) {
        double valor = 0;
        if (value.trim().isEmpty) {
          valor = 0;
        } else {
          valor = double.parse(value);
        }
        conversorprovider.valueFirst = valor;

        conversorprovider.convert(
          dolar: monedaProvider.dolar,
          euro: monedaProvider.euro,
        );
      },
      decoration: const InputDecoration(
        hintText: '0',
        hintStyle: TextStyle(
          fontSize: 20,
          color: AppColors.letterLight,
        ),
      ),
      style: const TextStyle(
        fontSize: 20,
        color: AppColors.letterLight,
      ),
    );
  }
}

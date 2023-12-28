import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudolar/helpers/colors.dart';
import 'package:tudolar/provider/conversor.provider.dart';
import 'package:tudolar/provider/moneda.provider.dart';

class DropdownFirst extends StatelessWidget {
  const DropdownFirst({super.key});

  @override
  Widget build(BuildContext context) {
    final monedaProvider = Provider.of<MonedaProvider>(context);
    final conversorProvider = Provider.of<ConversorProvider>(context);
    final dropdownFirst = conversorProvider.dropdownFirst;

    return DropdownMoneda(
      valor: dropdownFirst,
      onChange: (String? value) {
        conversorProvider.dropdownFirst = value!;
        conversorProvider.convert(
          dolar: monedaProvider.dolar,
          euro: monedaProvider.euro,
        );
      },
    );
  }
}

class DropdownSecond extends StatelessWidget {
  const DropdownSecond({super.key});

  @override
  Widget build(BuildContext context) {
    final monedaProvider = Provider.of<MonedaProvider>(context);
    final conversorProvider = Provider.of<ConversorProvider>(context);
    final dropdownSecond = conversorProvider.dropdownSecond;

    return DropdownMoneda(
      valor: dropdownSecond,
      onChange: (String? value) {
        conversorProvider.dropdownSecond = value!;
        conversorProvider.convert(
          dolar: monedaProvider.dolar,
          euro: monedaProvider.euro,
        );
      },
    );
  }
}

class DropdownMoneda extends StatelessWidget {
  const DropdownMoneda({
    required this.valor,
    required this.onChange,
    super.key,
  });

  final String valor;
  final Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      onChanged: onChange,
      value: valor,
      icon: const Icon(Icons.arrow_drop_down),
      iconEnabledColor: AppColors.letterDark,
      dropdownColor: AppColors.backgroundColor,
      iconSize: 30,
      style: const TextStyle(
        color: AppColors.letterDark,
        fontSize: 20,
      ),
      underline: Container(height: 0),
      isExpanded: true,
      items: const [
        DropdownMenuItem(
          value: "bolivar",
          child: Text(
            'Bolívar',
            style: TextStyle(fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: "dolar",
          child: Text(
            'Dólar',
            style: TextStyle(fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: "euro",
          child: Text(
            'Euro',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudolar/helpers/colors.dart';
import 'package:tudolar/provider/conversor.provider.dart';
import 'package:tudolar/provider/moneda.provider.dart';
import 'package:tudolar/widgets/dropdown.dart';
import 'package:tudolar/widgets/input_form.dart';

class FormBodyHome extends StatelessWidget {
  const FormBodyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final monedaProvider = Provider.of<MonedaProvider>(context);
    final conversorprovider = Provider.of<ConversorProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DropdownFirst(),
        const InputForm(),
        const SizedBox(height: 20),
        Center(
          child: IconButton(
            onPressed: () async {
              conversorprovider.swap();
              conversorprovider.convert(
                dolar: monedaProvider.dolar,
                euro: monedaProvider.euro,
              );
            },
            icon: const Icon(
              Icons.swap_horiz,
              color: AppColors.letterLight,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const DropdownSecond(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: AppColors.letterLight,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Text(
            conversorprovider.valueSecond,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.backgroundColor,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudolar/helpers/colors.dart';
import 'package:tudolar/provider/moneda.provider.dart';
import 'package:tudolar/widgets/title.dart';

class Error404 extends StatelessWidget {
  const Error404({super.key});

  @override
  Widget build(BuildContext context) {
    final monedaProvider = Provider.of<MonedaProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Header(),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off,
                  size: 50,
                  color:
                      AppColors.letterLight, // Reemplaza con tu color deseado
                ),
                const Text('No hay conexión a internet'),
                const SizedBox(height: 20),
                const Text(
                  '¿Continuar con la última actualización?',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.letterLight,
                  ),
                ),
                Text(
                  ' ${monedaProvider.date.day}/${monedaProvider.date.month}/${monedaProvider.date.year} ${monedaProvider.date.hour}:${monedaProvider.date.minute}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.letterLight,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    monedaProvider.isOnline = true;
                  },
                  child: const Text('Continuar'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

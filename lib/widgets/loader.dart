import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudolar/home.dart';
import 'package:tudolar/provider/moneda.provider.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> redirect() async {
      final monedaProvider = Provider.of<MonedaProvider>(context);

      await monedaProvider.checkInternet();

      return monedaProvider.isOnline;
    }

    return FutureBuilder<bool>(
      future: redirect(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
            return Container();
          } else {
            return Container();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

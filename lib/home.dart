import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tudolar/provider/moneda.provider.dart';
import 'package:tudolar/widgets/body_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final monedaProvider = Provider.of<MonedaProvider>(context);
    bool loading = monedaProvider.loading;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : const BodyHome(),
        ),
      ),
    );
  }
}

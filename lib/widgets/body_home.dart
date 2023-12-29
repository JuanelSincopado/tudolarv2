import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tudolar/provider/moneda.provider.dart';
import 'package:tudolar/widgets/average_card.dart';
import 'package:tudolar/widgets/banner.dart';
import 'package:tudolar/widgets/form.dart';
import 'package:tudolar/widgets/title.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final monedaProvider = Provider.of<MonedaProvider>(context);

    return SmartRefresher(
        controller: monedaProvider.controller,
        onRefresh: monedaProvider.onRefresh,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Header(),
                  SizedBox(height: 20),
                  AverageCard(),
                  SizedBox(height: 20),
                  FormBodyHome(),
                ],
              ),
            ),
            const Spacer(),
            if (monedaProvider.isOnline) const MyBanner(),
          ],
        ));
  }
}

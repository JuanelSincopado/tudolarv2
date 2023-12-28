import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tudolar/helpers/colors.dart';
import 'package:tudolar/home.dart';
import 'package:tudolar/provider/conversor.provider.dart';
import 'package:tudolar/provider/moneda.provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MonedaProvider.instance()),
        ChangeNotifierProvider(create: (_) => ConversorProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: AppColors.letterLight,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const Home(),
      ),
    );
  }
}

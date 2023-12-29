import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tudolar/helpers/colors.dart';
import 'package:tudolar/home.dart';
import 'package:tudolar/provider/conversor.provider.dart';
import 'package:tudolar/provider/moneda.provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  RequestConfiguration configuration = RequestConfiguration(
    testDeviceIds: <String>["067009509E3DF4839565F8BAE5E24493"],
  );
  MobileAds.instance.updateRequestConfiguration(configuration);

  await Hive.initFlutter();

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
        title: 'Tu Dolar',
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
        builder: (context, child) => Stack(
          children: [child!, const DropdownAlert()],
        ),
        home: const Home(),
      ),
    );
  }
}

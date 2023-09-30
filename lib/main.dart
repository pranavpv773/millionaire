import 'package:OWPM/app/secret_files/stripe_env.dart';
import 'package:OWPM/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'app/multi_providers/multi_providers.dart';
import 'app/theme/text_theme.dart';
import 'utils/apppref.dart';
import 'utils/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.init();
  Stripe.publishableKey = StripeEnv.stripeKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
        ],

        theme: ThemeData(
            primaryColor: AppColors.primary, textTheme: textThemeLight()),
        title: 'Millionaire',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        onGenerateRoute: RouteGenerator.generateRoute,
        // home: LoginScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:millionaire_app/utils/colors.dart';

import 'controller/multi_providers/multi_providers.dart';
import 'utils/apppref.dart';
import 'utils/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.init();

  Stripe.publishableKey =
      "pk_test_51NJUz3SHMOClJV0JOpAe3PgdzXJnmYXYF9K9nqr8mndgdIzFT8NHKbmMh3JliFNIN5i9jsP2L4m0wSFcPGU12MbD00FkXLPd4T";
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
        theme: ThemeData(textTheme: _textThemeLight()),
        title: 'Millionaire',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        onGenerateRoute: RouteGenerator.generateRoute,
        // home: LoginScreen(),
      ),
    );
  }
}

TextTheme _textThemeLight() {
  return TextTheme(
    displayLarge: GoogleFonts.heebo(
        height: 1.2,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    displayMedium: GoogleFonts.heebo(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    displaySmall: GoogleFonts.heebo(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    headlineMedium: GoogleFonts.heebo(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    headlineSmall: GoogleFonts.heebo(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    bodyLarge: GoogleFonts.heebo(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    bodyMedium: GoogleFonts.heebo(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    titleMedium: GoogleFonts.heebo(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    titleSmall: GoogleFonts.heebo(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    bodySmall: GoogleFonts.heebo(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.black),
    labelLarge: GoogleFonts.heebo(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.white),
    titleLarge: GoogleFonts.heebo(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: const Color(0xff181C1F),
    ),
  );
}

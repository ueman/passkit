import 'package:app/l10n/app_localizations.dart';
import 'package:app/router.dart';
import 'package:app/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessenger,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.system,
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateRoute: routeGenerator,
    );
  }
}

ThemeData _lightTheme() {
  var baseTheme = ThemeData(brightness: Brightness.light, useMaterial3: true);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
  );
}

ThemeData _darkTheme() {
  var baseTheme = ThemeData(brightness: Brightness.dark, useMaterial3: true);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
  );
}

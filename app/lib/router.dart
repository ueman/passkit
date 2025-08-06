import 'package:app/example/example_passes.dart';
import 'package:app/home/home_page.dart';
import 'package:app/import_order/import_order_page.dart';
import 'package:app/import_pass/import_page.dart';
import 'package:app/pass_backside/pass_backside_page.dart';
import 'package:app/pass_detail/pass_detail_page.dart';
import 'package:app/pass_detail/pass_detail_page_args.dart';
import 'package:app/settings/settings_page.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

NavigatorState get navigator => navigatorKey.currentState!;

Route<dynamic>? routeGenerator(RouteSettings settings) {
  return switch (settings.name) {
    '/' => MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),
    '/import' => MaterialPageRoute(
        builder: (context) {
          return ImportPassPage(
            source: settings.arguments as PkPassImportSource,
          );
        },
      ),
    '/importOrder' => MaterialPageRoute(
        builder: (context) {
          return ImportOrderPage(
            source: settings.arguments as PkOrderImportSource,
          );
        },
      ),
    '/examples' => MaterialPageRoute(
        builder: (context) {
          return const ExamplePasses();
        },
      ),
    '/settings' => MaterialPageRoute(
        builder: (context) {
          return const SettingsPage();
        },
      ),
    '/pass' => MaterialPageRoute(
        builder: (context) {
          final args = settings.arguments as PassDetailPageArgs;
          return PassDetailPage(
            pass: args.pass,
            showDelete: args.showDelete,
          );
        },
      ),
    '/backside' => MaterialPageRoute(
        builder: (context) {
          final args = settings.arguments as PassBackSidePageArgs;
          return PassBacksidePage(
            pass: args.pass,
            showDelete: args.showDelete,
          );
        },
      ),
    _ => MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),
  };
}

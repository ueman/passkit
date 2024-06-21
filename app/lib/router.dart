import 'package:app/home_page.dart';
import 'package:app/import_pass/import_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/import',
      builder: (context, state) => ImportPassPage(path: state.extra as String),
    ),
  ],
);

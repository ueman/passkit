import 'package:app/example/example_passes.dart';
import 'package:app/home_page.dart';
import 'package:app/import_pass/import_page.dart';
import 'package:app/pass_backside/pass_backside_page.dart';
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
    GoRoute(
      path: '/examples',
      builder: (context, state) => const ExamplePasses(),
    ),
    GoRoute(
      path: '/backside',
      builder: (context, state) {
        final args = state.extra as PassBackSidePageArgs;
        return PassBacksidePage(
          pass: args.pass,
          showDelete: args.showDelete,
        );
      },
    ),
  ],
);

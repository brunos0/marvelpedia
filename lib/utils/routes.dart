import 'package:flutter/material.dart';
import 'package:marvelpedia/pages/auth_or_app_page.dart';
import 'package:marvelpedia/pages/heroes_page.dart';
import 'package:marvelpedia/pages/hero_detail.dart';
import 'package:marvelpedia/utils/app_routes.dart';

class Routes {
  final Map<String, Widget Function(BuildContext)> routesMap = {
    AppRoutes.heroPage: (ctx) => const HeroesPage(),
    AppRoutes.heroDetail: (ctx) => const HeroDetail(),
    AppRoutes.authOrAppPage: (ctx) => const AuthOrAppPage(),
  };
  get routes {
    return routesMap;
  }

  get initialRoute {
    return AppRoutes.authOrAppPage;
  }
}

class HeroPage {
  const HeroPage();
}

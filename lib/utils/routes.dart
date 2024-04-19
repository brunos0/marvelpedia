import 'package:flutter/material.dart';
import 'package:marvelpedia/pages/heroes_page.dart';
import 'package:marvelpedia/pages/intro.dart';
import 'package:marvelpedia/pages/hero_detail.dart';
import 'package:marvelpedia/utils/app_routes.dart';

class Routes {
  final Map<String, Widget Function(BuildContext)> routesMap = {
    AppRoutes.intro: (ctx) => const Intro(),
    AppRoutes.heroPage: (ctx) => const HeroesPage(),
    AppRoutes.heroDetail: (ctx) => const HeroDetail(),
  };
  get routes {
    return routesMap;
  }

  get initialRoute {
    return AppRoutes.heroPage; //.intro;
  }
}

class HeroPage {
  const HeroPage();
}

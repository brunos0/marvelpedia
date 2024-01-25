import 'package:flutter/material.dart';
import 'package:pocketpedia/utils/app_routes.dart';

void onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      Navigator.of(context).pushNamed(
        AppRoutes.pokemonPage,
        //arguments: index,
      );
    case 1:
      Navigator.of(context).pushNamed(
        AppRoutes.pokemonFavorites,
        //arguments: index,
      );
    case 2:
      Navigator.of(context).pushNamed(AppRoutes.profile);
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/widgets/heroes_list.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/widgets/favorites_list.dart';
import 'package:marvelpedia/injection_container.dart' as di;

class HeroesDisplay extends StatelessWidget {
  HeroesDisplay({
    required this.favorites,
    required this.navBarKey,
    super.key,
  });

  final bool favorites;
  final GlobalKey navBarKey;
  final Heroes heroes = di.sl<Box<Heroes>>().getAt(0)!;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (favorites) {
      var result = heroes.heroes.any((hero) => hero.favorite == true);

      if (!result) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Go ahead and favorite some Pokemon!',
              ),
            ],
          ),
        );
      }
      return FavoritesList(width: width, height: height, navBarKey: navBarKey);
    } else {
      return HeroesList(
        width: width,
        height: height,
      );
    }
  }
}

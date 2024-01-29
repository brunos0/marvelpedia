import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/carousel_list.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/favorites_list.dart';
import 'package:pocketpedia/injection_container.dart' as di;

class PokemonsDisplay extends StatelessWidget {
  PokemonsDisplay({
    required this.favorites,
    required this.navBarKey,
    super.key,
  });

  final bool favorites;
  final GlobalKey navBarKey;
  final Pokemons pokemons = di.sl<Box<Pokemons>>().getAt(0)!;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (favorites) {
      var result = pokemons.pokemons.any((pokemon) => pokemon.favorite == true);

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
      return CarouselList(
        width: width,
        height: height,
      );
    }
  }
}

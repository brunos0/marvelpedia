import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/pokemon_clip.dart';
import 'package:pocketpedia/injection_container.dart' as di;

class PokemonsDisplay extends StatelessWidget {
  PokemonsDisplay({
    required this.favorites,
    super.key,
  });

  final bool favorites;
  final Pokemons pokemons = di.sl<Box<Pokemons>>().getAt(0)!;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (favorites) {
      var result = pokemons.pokemons.any((pokemon) => pokemon.favorite == true);

      if (!result) {
        return const Center(
          child: Text(
            'Go ahead and favorite some Pokemon!',
          ),
        );
      }
    }

    return SingleChildScrollView(
      child: Row(
        children: [
          SizedBox(
            width: width * 0.95,
            height: height * 0.95,
            child: ListView.builder(
              itemCount: null,
              itemBuilder: (BuildContext context, int index) {
                final indexItem = index % pokemons.pokemons.length;
                //if (indexItem < pokemons.pokemons.length) break ;
                print(indexItem);
                return !favorites
                    ? SizedBox(
                        width: width * 0.9,
                        height: height * 0.15,
                        child: PokemonClip(
                          index: indexItem,
                        ),
                      )

                    /// show only favorite ones
                    : pokemons.pokemons[indexItem].favorite
                        ? SizedBox(
                            width: width * 0.9,
                            height: height * 0.15,
                            child: PokemonClip(
                              index: indexItem,
                            ),
                          )
                        : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

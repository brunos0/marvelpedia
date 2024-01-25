import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/pokemon_clip.dart';
import 'package:pocketpedia/injection_container.dart' as di;

class PokemonsFavoritesDisplay extends StatelessWidget {
  PokemonsFavoritesDisplay({
    super.key,
  });

  final Pokemons pokemons = di.sl<Box<Pokemons>>().getAt(0)!;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(children: [
        SizedBox(
          width: 370,
          height: 650,
          child: ListView.builder(
            itemCount: pokemons.pokemons.length,
            itemBuilder: (BuildContext context, int index) {
              return pokemons.pokemons[index].favorite
                  ? Center(
                      child: SizedBox(
                          width: 370,
                          height: 130,
                          child: PokemonClip(index: index)),
                    )
                  : Container();
            },
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/pokemon_clip.dart';

class PokemonsDisplay extends StatelessWidget {
  const PokemonsDisplay({
    required this.pokemons,
    super.key,
  });

  final Pokemons pokemons;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //scrollDirection: Axis.horizontal,
      child: Row(children: [
        SizedBox(
          width: 370,
          height: 730,
          child: ListView.builder(
            //scrollDirection: Axis.horizontal,
            itemCount: pokemons.pokemons.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                  width: 370,
                  height: 130,
                  child: PokemonClip(
                      pokemonNumber: pokemons.pokemons[index].number,
                      pokemonName: pokemons.pokemons[index].name,
                      pokemonTypes: pokemons.pokemons[index].types!));
            },
          ),
        ),
      ]),
    );
  }
}

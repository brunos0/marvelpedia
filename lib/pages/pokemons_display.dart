import 'package:flutter/material.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';

class PokemonsDisplay extends StatelessWidget {
  const PokemonsDisplay({
    required this.pokemons,
    super.key,
  });

  final Pokemons pokemons;
  @override
  Widget build(BuildContext context) {
    return Container();
    /*
    
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        SizedBox(
          width: 400,
          height: 600,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.movies.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                  width: 300,
                  height: 600,
                  child: MovieClip(
                      movieName: movies.movies[index].originalTitle,
                      movieDescription: movies.movies[index].overview,
                      moviePoster: movies.movies[index].urlCover));
            },
          ),
        ),
      ]),
    );
    */
  }
}

import 'package:flutter/material.dart';
import 'package:pocketpedia/utils/app_routes.dart';

class PokemonClip extends StatelessWidget {
  const PokemonClip(
      {required this.movieName,
      required this.movieDescription,
      required this.moviePoster,
      super.key});

  final String movieName;
  final String movieDescription;
  final String moviePoster;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              movieName,
              textAlign: TextAlign.center,
            ),
          ),
          child: GestureDetector(
            child: Hero(
              tag: movieName,
              child: FadeInImage(
                placeholder: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/$moviePoster'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/$moviePoster'),
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.movieDetail,
                arguments: (movieName, movieDescription, moviePoster),
              );
            },
          ),
        ),
      ),
    );
  }
}

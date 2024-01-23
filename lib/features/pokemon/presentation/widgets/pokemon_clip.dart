import 'package:flutter/material.dart';
import 'package:pocketpedia/utils/app_routes.dart';
import 'package:pocketpedia/utils/color_picker.dart';

class PokemonClip extends StatelessWidget {
  const PokemonClip(
      {required this.pokemonNumber,
      required this.pokemonName,
      required this.pokemonTypes,
      super.key});

  final String pokemonNumber;
  final String pokemonName;
  final List<String> pokemonTypes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipPath(
        clipper: MyCustomClipper(),
        child: Container(color: colorTypeBackgroundPicker(pokemonTypes[0])),

        //Container(color: colorTypePicker(pokemonTypes[0])),
      ),
      /*
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          /*
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              pokemonName,
              textAlign: TextAlign.center,
            ),
          ),
          */

          child: GestureDetector(
            child: Hero(
              tag: pokemonName,
              child: FadeInImage(
                placeholder:
                    // TODO(bruno): se pikachu então imagem local
                    NetworkImage(
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumber.png'),
                image: NetworkImage(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumber.png'),
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              /*
              Navigator.of(context).pushNamed(
                AppRoutes.movieDetail,
                arguments: (movieName, movieDescription, moviePoster),
              );
              */
            },
          ),
        ),
      ),

      */
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    path.addRRect(RRect.fromRectAndRadius(
        rect,
        const Radius.circular(
            30.0))); // Ajuste o valor para alterar a curvatura
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

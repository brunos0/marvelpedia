import 'package:flutter/material.dart';
import 'package:pocketpedia/utils/app_routes.dart';
import 'package:pocketpedia/utils/color_picker.dart';
import 'package:pocketpedia/utils/string_extensions.dart';

class PokemonClip extends StatelessWidget {
  const PokemonClip(
      {required this.pokemonNumber,
      required this.pokemonName,
      required this.pokemonTypes,
      super.key});

  final String pokemonNumber;
  final String pokemonName;
  final List<String> pokemonTypes;

  List listTypes(List<String> list) {
    List tiles = [];
    for (int i = 0; i < list.length; i++) {
      tiles.add(
        ClipPath(
          clipper: PKClipper(),
          child: Container(
            height: 20,
            width: 60,
            color: colorTypePicker(list[i]),
            // TODO(bruno): icon
            child: Center(
                child: Text(
              list[i].split(' ').map((word) => word.capitalize()).join(' '),
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            )),
          ),
        ),
      );
      tiles.add(const Spacer(flex: 1));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipPath(
        clipper: PKClipper(),
        child: Container(
          color: colorTypeBackgroundPicker(pokemonTypes[0]),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 10),
                child: SizedBox(
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        '#${pokemonNumber.padLeft(3, '0')}',
                        style: TextStyle(fontSize: 14, fontFamily: 'ROBOTO'),
                      ),
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          pokemonName
                              .split(' ')
                              .map((word) => word.capitalize())
                              .join(' '),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ROBOTO'),
                        ),
                      ),
                      const Spacer(),
                      Row(children: [...listTypes(pokemonTypes)]),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 190,
                child: Container(
                  // color: Colors.red,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset('assets/pokeball.png',
                              height: 140,
                              width: 140,
                              alignment: Alignment.centerRight,
                              colorBlendMode: BlendMode.modulate),
                        ),
                      ),
                      // TODO(bruno): se pikachu então imagem local
                      GestureDetector(
                          child: Hero(
                            tag: pokemonName,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: FadeInImage(
                                alignment: Alignment.bottomLeft,
                                height: 100,
                                width: 100,
                                placeholder:

                                    // TODO(bruno): se pikachu então imagem local
                                    NetworkImage(
                                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumber.png'),
                                image: NetworkImage(
                                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumber.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            /*
                          Navigator.of(context).pushNamed(
                            AppRoutes.movieDetail,
                            arguments: (movieName, movieDescription, moviePoster),
                          );
                          */
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PKClipper extends CustomClipper<Path> {
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_event.dart';
import 'package:pocketpedia/utils/app_routes.dart';
import 'package:pocketpedia/utils/color_picker.dart';
import 'package:pocketpedia/utils/string_extensions.dart';
import 'package:pocketpedia/injection_container.dart' as di;

// ignore: must_be_immutable
class PokemonClip extends StatelessWidget {
  PokemonClip(
      {required this.width,
      required this.height,
      required this.index,
      super.key});
  final int index;
  final double width;
  final double height;
  final Pokemons pokemons = di.sl<Box<Pokemons>>().getAt(0)!;

  late String pokemonNumber;
  late String pokemonName;
  late List<String> pokemonTypes;
  late bool favorite;
  late ImageProvider image;

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset('assets/types/${list[i]}.svg'),
                Text(
                  list[i].split(' ').map((word) => word.capitalize()).join(' '),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      tiles.add(const Spacer(flex: 1));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    pokemonNumber = pokemons.pokemons[index].number;
    pokemonName = pokemons.pokemons[index].name;
    pokemonTypes = pokemons.pokemons[index].types!;
    favorite = pokemons.pokemons[index].favorite;

    if (pokemonNumber == '25') {
      image = const AssetImage('assets/pikachu.png');
    } else {
      image = NetworkImage(
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumber.png');
    }

    return SizedBox(
      width: width * 0.9,
      height: height * 0.15,
      child: Padding(
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
                          style: const TextStyle(
                              fontSize: 14, fontFamily: 'ROBOTO'),
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
                        GestureDetector(
                          child: Hero(
                            tag: pokemonName,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: FadeInImage(
                                alignment: Alignment.bottomLeft,
                                height: 100,
                                width: 100,
                                placeholder: image,
                                image: image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.pokemonDetail,
                              arguments: index,
                            );
                          },
                        ),
                        Visibility(
                          visible: favorite,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 20, left: 150),
                            child: Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 140),
                          child: IconButton(
                            icon: const Icon(Icons.favorite_border),
                            onPressed: () {
                              pokemons.pokemons[index].favorite =
                                  !pokemons.pokemons[index].favorite;
                              pokemons.save();

                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: pokemons.pokemons[index].favorite
                                      ? Text(
                                          '${pokemons.pokemons[index].name} favoritado!')
                                      : Text(
                                          '${pokemons.pokemons[index].name} desfavoritado!'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );

                              BlocProvider.of<PokemonsBloc>(context)
                                  .add(RefreshEvent());
                            },
                            iconSize: 40,
                            style: IconButton.styleFrom(
                              elevation: 5,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

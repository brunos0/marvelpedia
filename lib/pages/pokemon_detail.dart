import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/pokemon_clip.dart';
import 'package:pocketpedia/injection_container.dart' as di;
import 'package:pocketpedia/utils/color_picker.dart';
import 'package:pocketpedia/utils/string_extensions.dart';

class PokemonDetail extends StatelessWidget {
  PokemonDetail({super.key});

  final Pokemons pokemons = di.sl<Box<Pokemons>>().getAt(0)!;
  late String pokemonNumber;
  late String pokemonName;
  late List<String> pokemonTypes;
  late bool favorite;
  late List<Color> bgFadeColor;

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;
    pokemonNumber = pokemons.pokemons[index].number;
    pokemonName = pokemons.pokemons[index].name;
    pokemonTypes = pokemons.pokemons[index].types!;
    favorite = pokemons.pokemons[index].favorite;
    bgFadeColor = colorTypeBGFadePicker(pokemonTypes[0]);

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
                    list[i]
                        .split(' ')
                        .map((word) => word.capitalize())
                        .join(' '),
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

    return MaterialApp(
      home: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 4,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        Center(
                            child: ClipPath(
                          clipper: MyCustomClipper(),
                          child: Container(
                              height: 200,
                              width: 380,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: bgFadeColor,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              )),
                        )),
                        SizedBox(
                          child: Opacity(
                            opacity: 0.05,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Image.asset('assets/pokeball.png',
                                    height: 140,
                                    width: 140,
                                    alignment: Alignment.bottomLeft,
                                    colorBlendMode: BlendMode.modulate),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 370,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 50, right: 150),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: OverflowBox(
                                      maxHeight: 200,
                                      child: pokemonNumber == '25'
                                          ? Image.asset(
                                              'assets/pikachu.png',
                                            )
                                          : Image.network(
                                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumber.png',
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 210,
                              bottom: 10,
                              top: 100,
                            ),
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
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'ROBOTO'),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      pokemonName
                                          .split(' ')
                                          .map((word) => word.capitalize())
                                          .join(' '),
                                      style: const TextStyle(
                                          color: Colors.white,
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TabBar(
                      indicatorColor: Colors.red,
                      labelColor: Colors.red,
                      tabs: <Widget>[
                        Text(
                          "About",
                        ),
                        Text('Stats'),
                        Text('Evolution'),
                        Text('Moves'),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBarView(
                        children: [
                          Container(
                            //height: 300,
                            //width: 300,
                            color: Colors.grey,
                          ),
                          Container(
                            color: Colors.grey,
                          ),
                          Container(
                            color: Colors.grey,
                          ),
                          Container(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var radius = 40.0; // Ajuste o valor para alterar a curvatura

    path.moveTo(0, size.height - size.height * 0.75 + radius + 20);
    path.quadraticBezierTo(0, size.height - size.height * 0.75 + 20, radius,
        size.height - size.height * 0.78 + 20);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

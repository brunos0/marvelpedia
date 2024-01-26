import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_event.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_state.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/pokemon_clip.dart';
import 'package:pocketpedia/injection_container.dart' as di;
import 'package:pocketpedia/injection_container.dart';
import 'package:pocketpedia/utils/color_picker.dart';
import 'package:pocketpedia/utils/string_extensions.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({super.key});

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  final Pokemons pokemons = di.sl<Box<Pokemons>>().getAt(0)!;
  late int index;
  late String pokemonNumber;
  late String pokemonName;
  late String pokemonHeight;
  late String pokemonWeight;
  late List<String> pokemonMoves;
  late List<String> pokemonTypes;
  late List<String> pokemonAbilities;
  late List<String> pokemonListEvolution;
  late List<Map<String, dynamic>>? pokemonStats;
  late bool favorite;
  late List<Color> bgFadeColor;
  String pokemonDescription = '';
  String pokemonCategory = '';
  String pokemonGender = '';

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

  List showStats() {
    int statSize = pokemonStats!.length;
    List stats = [];
    int total = 0;
    for (int i = 0; i < statSize; i++) {
      String descr = pokemonStats![i].keys.first;
      int value = pokemonStats![i][descr];
      if (descr == 'hp') {
        descr = 'HP';
      }
      if (descr == 'attack') {
        descr = 'Attack';
      }
      if (descr == 'defense') {
        descr = 'Defense';
      }
      if (descr == 'special-attack') {
        descr = 'Sp. Atk';
      }
      if (descr == 'special-defense') {
        descr = 'Sp. Def';
      }
      if (descr == 'speed') {
        descr = 'Speed';
      }

      stats.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              descr,
            ),
            const Gap(10),
            Text(value.toString())
          ],
        ),
      );
      total += value;
    }
    stats.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Total',
          ),
          const Gap(10),
          Text(total.toString())
        ],
      ),
    );
    return stats;
  }

  List listMoves() {
    List listMoves = [];
    int sizeMoves = pokemonMoves.length;
    for (int i = 0; i < sizeMoves; i++) {
      listMoves.add(Text(pokemonMoves[i]));
    }
    return listMoves;
  }

  @override
  Widget build(BuildContext context) {
    index = ModalRoute.of(context)!.settings.arguments as int;
    pokemonNumber = pokemons.pokemons[index].number;
    pokemonName = pokemons.pokemons[index].name;
    pokemonTypes = pokemons.pokemons[index].types!;
    favorite = pokemons.pokemons[index].favorite;
    pokemonHeight = pokemons.pokemons[index].height.toString();
    pokemonWeight = pokemons.pokemons[index].weight.toString();
    pokemonMoves = pokemons.pokemons[index].moves!;
    pokemonStats = pokemons.pokemons[index].stats;
    pokemonAbilities = pokemons.pokemons[index].abilities!;
    bgFadeColor = colorTypeBGFadePicker(pokemonTypes[0]);

    return MaterialApp(
      home: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 4,
          child: Scaffold(
            body: BlocProvider<DetailsBloc>(
              create: (_) => sl<DetailsBloc>(),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: BlocBuilder<DetailsBloc, DetailsState>(
                  builder: (context, state) {
                    if (state is DetailsEmpty) {
                      BlocProvider.of<DetailsBloc>(context)
                          .add(DetailsLoadingEvent());
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DetailsLoaded) {
                      var listEvolution;
                      var description;
                      var category;
                      (listEvolution, description, category) =
                          state.result as (List, String, String);

                      pokemonListEvolution = listEvolution;
                      pokemonCategory = category;
                      pokemonDescription = description;

                      BlocProvider.of<DetailsBloc>(context)
                          .add(DetailsRefreshEvent());
                    }

                    return Column(
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
                                    ),
                                  ),
                                ),
                              ),
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
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 210,
                                    bottom: 10,
                                    top: 100,
                                  ),
                                  child: SizedBox(
                                    width: 130,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                .map(
                                                    (word) => word.capitalize())
                                                .join(' '),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'ROBOTO'),
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            ...listTypes(pokemonTypes)
                                          ],
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Visibility(
                                visible: pokemons.pokemons[index].favorite,

                                /*
                                di
                                    .sl<Box<Pokemons>>()
                                    .getAt(0)!
                                    .pokemons[index]
                                    .favorite,
                                //favorite,
                                
                                */
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 20, left: 330),
                                  child: Icon(
                                    Icons.favorite_outlined,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 320),
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
                                        content: pokemons
                                                .pokemons[index].favorite
                                            ? Text(
                                                '${pokemons.pokemons[index].name} favoritado!')
                                            : Text(
                                                '${pokemons.pokemons[index].name} desfavoritado!'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );

                                    BlocProvider.of<DetailsBloc>(context)
                                        .add(DetailsRefreshEvent());
                                  },
                                  iconSize: 40,
                                  style: IconButton.styleFrom(
                                    elevation: 5,
                                  ),
                                ),
                              )
                              //aqui
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
                                Center(
                                  child: Container(
                                    color: Colors.grey,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Description"),
                                          Text(pokemonDescription),
                                          const Gap(30),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text("Height"),
                                                  Text(pokemonHeight),
                                                ],
                                              ),
                                              const Gap(30),
                                              Column(
                                                children: [
                                                  const Text("Weight"),
                                                  Text(pokemonWeight),
                                                ],
                                              ),
                                              const Gap(30),
                                              Column(
                                                children: [
                                                  const Text("Gender"),
                                                  Text(pokemonGender),
                                                ],
                                              )
                                            ],
                                          ),
                                          const Gap(30),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text("Category"),
                                                  Text(pokemonCategory),
                                                ],
                                              ),
                                              const Gap(30),
                                              Column(
                                                children: [
                                                  const Text("Abilities"),
                                                  Text(pokemonAbilities.first),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    color: Colors.grey,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [...showStats()],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      color: Colors.grey,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [...listMoves()],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
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

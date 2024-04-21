import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/details_bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/details_event.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/details_state.dart';
//import 'package:marvelpedia/features/marvel_heroes/presentation/widgets/pkclipper.dart';
import 'package:marvelpedia/injection_container.dart' as di;
import 'package:marvelpedia/injection_container.dart';
//import 'package:marvelpedia/utils/color_picker.dart';
import 'package:marvelpedia/utils/string_extensions.dart';

class HeroDetail extends StatefulWidget {
  const HeroDetail({super.key});

  @override
  State<HeroDetail> createState() => _HeroDetailState();
}

class _HeroDetailState extends State<HeroDetail> {
  final Heroes heroes = di.sl<Box<Heroes>>().getAt(0)!;
  late int index;
  late int heroId;
  late String heroName;
  late List heroComics;
  late String image;
  late bool favorite;

  String heroDescription = '';

  @override
  Widget build(BuildContext context) {
    index = ModalRoute.of(context)!.settings.arguments as int;
    heroId = heroes.heroes[index].id;
    heroName = heroes.heroes[index].name;
    heroComics = heroes.heroes[index].comics!;
    favorite = heroes.heroes[index].favorite;
    image = //NetworkImage(
        heroes.heroes[index].profilePicture; //);

    if (heroes.heroes[index].profilePicture.contains('image_not_available')) {
      image =
          'https://static.vecteezy.com/ti/vetor-gratis/p3/7725022-perfil-icone-ui-icon-vetor.jpg';
    }

    return MaterialApp(
      home: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            body: BlocProvider<DetailsBloc>(
              create: (_) => sl<DetailsBloc>(),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: BlocBuilder<DetailsBloc, DetailsState>(
                  builder: (context, state) {
                    if (state is DetailsEmpty) {
                      BlocProvider.of<DetailsBloc>(context)
                          .add(DetailsLoadingEvent(index));
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DetailsLoaded) {
                      /*
                      var listEvolution;
                      var description;
                      var category;
                      (listEvolution, description, category) =
                          state.result as (List, String, String);

                      pokemonListEvolution = listEvolution;
                      pokemonCategory = category;
                      pokemonDescription = description;
                      */
                      BlocProvider.of<DetailsBloc>(context)
                          .add(DetailsRefreshEvent());
                    }

                    return Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
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
                                              child: Image.network(image)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 250,
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
                                          '#$heroId',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'ROBOTO'),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(
                                            heroName
                                                .split(' ')
                                                .map(
                                                    (word) => word.capitalize())
                                                .join(' '),
                                            style: const TextStyle(
                                                //color: Colors.,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'ROBOTO'),
                                          ),
                                        ),
                                        const Spacer(),
                                        const Row(
                                          children: [
                                            // ...listTypes(pokemonTypes)
                                          ],
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: heroes.heroes[index].favorite,
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
                                    heroes.heroes[index].favorite =
                                        !heroes.heroes[index].favorite;
                                    heroes.save();

                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: heroes.heroes[index].favorite
                                            ? Text(
                                                '${heroes.heroes[index].name} has been favorited!')
                                            : Text(
                                                '${heroes.heroes[index].name} has been unfavorited!'),
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(
                            15,
                            0,
                            15,
                            0,
                          ),
                          child: TabBar(
                            dividerColor: Colors.transparent,
                            indicatorColor: Colors.red,
                            labelColor: Colors.red,
                            tabs: <Widget>[
                              Text(
                                "About",
                              ),
                              Text('Comics'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              //About
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Container(
                                    color: const Color(0XFFF7F7F7),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            60, 30, 60, 0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 300,
                                              child: Text(
                                                heroDescription,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            const Gap(30),
                                            const Text('xpto')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //stats
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Container(
                                    color: const Color(0XFFF7F7F7),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            60, 30, 60, 0),
                                        child: Column(
                                            // children: [...showStats()],
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //evolutions
                            ],
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
    var radius = 40.0;

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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_event.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/widgets/pkclipper.dart';
import 'package:marvelpedia/injection_container.dart' as di;
import 'package:marvelpedia/utils/app_routes.dart';
//import 'package:marvelpedia/utils/color_picker.dart';
import 'package:marvelpedia/utils/string_extensions.dart';

// ignore: must_be_immutable
class HeroClip extends StatelessWidget {
  HeroClip(
      {required this.width,
      required this.height,
      required this.index,
      super.key});
  final int index;
  final double width;
  final double height;

  final Heroes heroes = di.sl<Box<Heroes>>().getAt(0)!;

  late int heroId;
  late String heroName;
  late List<Set> heroComics;
  late bool favorite;
  late ImageProvider image;

/*
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
*/
  @override
  Widget build(BuildContext context) {
    heroId = heroes.heroes[index].id;
    heroName = heroes.heroes[index].name;
    heroComics = heroes.heroes[index].comics!;
    favorite = heroes.heroes[index].favorite;
    /*
    if (pokemonNumber == '25') {
      image = const AssetImage('assets/pikachu.png');
    } else {
      image = NetworkImage(
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumber.png');
    }
*/
    //dummy image
    image = const NetworkImage(
        'https://static.vecteezy.com/ti/vetor-gratis/p3/7725022-perfil-icone-ui-icon-vetor.jpg');
    return SizedBox(
      width: width * 0.9,
      height: height * 0.15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipPath(
          clipper: PKClipper(),
          child: Container(
            color: Colors.white, //colorTypeBackgroundPicker(pokemonTypes[0]),
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
                          '#$heroId',
                          style: const TextStyle(
                              fontSize: 14, fontFamily: 'ROBOTO'),
                        ),
                        FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            heroName
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
                        // Row(children: [...listTypes(pokemonTypes)]),
                        // const Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: Stack(
                    children: [
                      /*
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
                      */
                      GestureDetector(
                        child: Hero(
                          tag: heroId,
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
                          Navigator.of(context)
                              .pushNamed(
                                AppRoutes.heroDetail,
                                arguments: index,
                              )
                              .then((_) => BlocProvider.of<HeroesBloc>(context)
                                  .add(RefreshEvent()));
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
                            heroes.heroes[index].favorite =
                                !heroes.heroes[index].favorite;
                            heroes.save();

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: heroes.heroes[index].favorite
                                    ? Text(
                                        '${heroes.heroes[index].name} has been favorited!')
                                    : Text(
                                        '${heroes.heroes[index].name}  has been unfavorited!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );

                            BlocProvider.of<HeroesBloc>(context)
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

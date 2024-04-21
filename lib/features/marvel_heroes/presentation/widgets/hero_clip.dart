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
  late List heroComics;
  late bool favorite;
  late ImageProvider image;

  @override
  Widget build(BuildContext context) {
    heroId = heroes.heroes[index].id;
    heroName = heroes.heroes[index].name;
    heroComics = heroes.heroes[index].comics!;
    favorite = heroes.heroes[index].favorite;
    image = NetworkImage(heroes.heroes[index].profilePicture);

    if (heroes.heroes[index].profilePicture.contains('image_not_available')) {
      image = const NetworkImage(
          'https://i.fbcd.co/products/resized/resized-750-500/d4c961732ba6ec52c0bbde63c9cb9e5dd6593826ee788080599f68920224e27d.jpg');
    }

    return SizedBox(
      width: width * 0.9,
      height: height * 0.15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipPath(
          clipper: PKClipper(),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  //width: 190,
                  child: GestureDetector(
                    child: Row(
                      children: [
                        Hero(
                          tag: heroId,
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                height: 100,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CircleAvatar(
                                    backgroundImage: image,
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 160,
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
                                      .trim()
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
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Visibility(
                              visible: favorite,
                              child: const Padding(
                                padding: EdgeInsets.only(top: 20, left: 50),
                                child: Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 40),
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
                        )
                      ],
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

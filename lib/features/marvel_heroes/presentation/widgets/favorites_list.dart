import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/widgets/hero_clip.dart';

import 'package:marvelpedia/injection_container.dart' as di;

class FavoritesList extends StatelessWidget {
  FavoritesList(
      {required this.width,
      required this.height,
      required this.navBarKey,
      super.key});

  final double width;
  final double height;
  final GlobalKey navBarKey;
  final Heroes heroes = di.sl<Box<Heroes>>().getAt(0)!;

  @override
  Widget build(BuildContext context) {
    final RenderBox box =
        navBarKey.currentContext!.findRenderObject() as RenderBox;
    final navBarSize = box.size.height;
    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        height: (height - navBarSize) * 0.93,
        child: ListView.builder(
          itemCount: heroes.heroes.length,
          itemBuilder: (BuildContext context, int index) {
            return heroes.heroes[index].favorite
                ? HeroClip(
                    width: width,
                    height: height,
                    index: index,
                  )
                : Container();
          },
        ),
      ),
    );
  }
}

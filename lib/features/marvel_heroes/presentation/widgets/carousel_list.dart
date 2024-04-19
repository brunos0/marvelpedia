import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/widgets/hero_clip.dart';
import 'package:marvelpedia/injection_container.dart' as di;

class CarouselList extends StatelessWidget {
  CarouselList({required this.width, required this.height, super.key});

  final double width;
  final double height;
  final Heroes heroes = di.sl<Box<Heroes>>().getAt(0)!;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        height: height,
        child: CarouselSlider.builder(
          itemCount: heroes.heroes.length,
          itemBuilder: (
            BuildContext context,
            int itemIndex,
            int pageViewIndex,
          ) {
            return HeroClip(
              width: width,
              height: height,
              index: itemIndex,
            );
          },
          options: CarouselOptions(
            initialPage: 3,
            enableInfiniteScroll: true,
            reverse: false,
            viewportFraction: 0.148,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }
}

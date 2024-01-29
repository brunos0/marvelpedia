import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/pokemon_clip.dart';
import 'package:pocketpedia/injection_container.dart' as di;

class CarouselList extends StatelessWidget {
  CarouselList({required this.width, required this.height, super.key});

  final double width;
  final double height;
  final Pokemons pokemons = di.sl<Box<Pokemons>>().getAt(0)!;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        height: height,
        child: CarouselSlider.builder(
          itemCount: pokemons.pokemons.length,
          itemBuilder: (
            BuildContext context,
            int itemIndex,
            int pageViewIndex,
          ) {
            return PokemonClip(
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

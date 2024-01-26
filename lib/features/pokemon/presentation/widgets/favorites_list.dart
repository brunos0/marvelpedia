import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/pokemon_clip.dart';
import 'package:pocketpedia/injection_container.dart' as di;

class FavoritesList extends StatelessWidget {
  FavoritesList(
      {required this.width,
      required this.height,
      required this.navBarKey,
      super.key});

  final double width;
  final double height;
  final GlobalKey navBarKey;
  final Pokemons pokemons = di.sl<Box<Pokemons>>().getAt(0)!;

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
          itemCount: pokemons.pokemons.length,
          itemBuilder: (BuildContext context, int index) {
            return pokemons.pokemons[index].favorite
                ? PokemonClip(
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

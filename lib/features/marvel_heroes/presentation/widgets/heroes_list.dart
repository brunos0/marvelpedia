//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_event.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/widgets/hero_clip.dart';
import 'package:marvelpedia/injection_container.dart' as di;

class HeroesList extends StatefulWidget {
  const HeroesList({required this.width, required this.height, super.key});

  final double width;
  final double height;

  @override
  State<HeroesList> createState() => _HeroesListState();
}

class _HeroesListState extends State<HeroesList> {
  final threshold = 1000;
  final _scrollController = ScrollController();

  Heroes heroes = di.sl<Box<Heroes>>().getAt(0)!;
  _HeroesListState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - threshold) {
        BlocProvider.of<HeroesBloc>(context).add(
          GetHeroesEvent(increment: true),
        );
        heroes = di.sl<Box<Heroes>>().getAt(0)!;
        print(di.sl<Box<Heroes>>().getAt(0)!.heroes.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ListView.builder(
          itemCount: heroes.heroes.length + 1,
          controller: _scrollController,
          itemBuilder: (
            BuildContext context,
            int itemIndex,
          ) {
            return HeroClip(
              width: widget.width,
              height: widget.height,
              index: itemIndex,
            );
          },
        ),
      ),
    );
  }
}

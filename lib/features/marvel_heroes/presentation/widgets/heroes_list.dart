//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  late ScrollController _scrollController;
  ValueListenable<Box<Heroes>> items = di.sl<Box<Heroes>>().listenable();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    /*if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - threshold) 
        */
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      //if (BlocProvider.of<HeroesBloc>(context).state is! UpdatedHeroesList) {
      BlocProvider.of<HeroesBloc>(context).add(
        GetHeroesEvent(increment: true),
      );
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ValueListenableBuilder(
            valueListenable: items,
            builder: (context, heroes, _) {
              return ListView.builder(
                itemCount: heroes.getAt(0)!.heroes.length,
                controller: _scrollController,
                itemBuilder: (
                  BuildContext context,
                  int itemIndex,
                ) {
                  print(heroes.getAt(0)!.heroes[itemIndex].id);
                  print(heroes.getAt(0)!.heroes[itemIndex].name);
                  return HeroClip(
                    width: widget.width,
                    height: widget.height,
                    index: itemIndex,
                  );
                },
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

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
  HeroesList({required this.width, required this.height, super.key});

  final double width;
  final double height;

  @override
  State<HeroesList> createState() => _HeroesListState();
}

class _HeroesListState extends State<HeroesList> {
  final Heroes heroes = di.sl<Box<Heroes>>().getAt(0)!;
  final threshold = 100300; //200.0;
  final _scrollController = ScrollController();

  _HeroesListState() {
    _scrollController.addListener(() {
      //if (lEntra)
      final maxScroll =
          _scrollController.position.maxScrollExtent; //maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if
          //(maxScroll - currentScroll <= threshold) {

          (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 1000) {
        print("vai atualizar");
        BlocProvider.of<HeroesBloc>(context).add(
          GetHeroesEvent(increment: true),
        );
      }
    });
  }

/*
  void _scrollListener() {
    final maxScroll = Scrollable.of(context).position.maxScrollExtent;
    final currentScroll = Scrollable.of(context).position.pixels;
    const threshold =
        200.0; // Define o limite de rolagem para carregar mais itens

    if (maxScroll - currentScroll <= threshold) {
      BlocProvider.of<HeroesBloc>(context).add(
        GetHeroesEvent(increment: true),
      );
      //BlocProvider.of<HeroesBloc>(context).getHeroes(true);
      //_loadMore();
    }
  }
*/
  bool lEntra = false;
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
            //int pageViewIndex,
          ) {
            return HeroClip(
              width: widget.width,
              height: widget.height,
              index: itemIndex,
            );
          },
          /*
          options: CarouselOptions(
            initialPage: 3,
            enableInfiniteScroll: true,
            reverse: false,
            viewportFraction: 0.148,
            scrollDirection: Axis.vertical,
          ),
          */
        ),
      ),
    );
  }
}

//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  //ValueListenable<bool> isLoading = ValueNotifier<bool>(false);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    items.addListener(() {
      setState(() {
        _isLoading = false;
        _scrollController.animateTo(
          _scrollController.offset + 300,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _isLoading = true;
      });
      BlocProvider.of<HeroesBloc>(context).add(
        GetHeroesEvent(increment: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height - 090,
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
                    return HeroClip(
                      width: widget.width,
                      height: widget.height,
                      index: itemIndex,
                    );
                  },
                );
              }),
        ),
        Visibility(
          visible: _isLoading, //isLoading.value,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

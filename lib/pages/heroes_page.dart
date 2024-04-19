import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_event.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_state.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/widgets/loading_widget.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/widgets/message_display.dart';
import 'package:marvelpedia/pages/heroes_display.dart';
import 'package:marvelpedia/pages/profile.dart';

class HeroesPage extends StatefulWidget {
  const HeroesPage({super.key});

  @override
  State<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  int _selectedIndex = 0;
  final navBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          key: navBarKey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Image.asset('assets/navbar/home_on.png')
                  : Image.asset('assets/navbar/home_off.png'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? Image.asset('assets/navbar/favorite_on.png')
                  : Image.asset('assets/navbar/favorite_off.png'),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? Image.asset('assets/navbar/profile_on.png')
                  : Image.asset('assets/navbar/profile_off.png'),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFF10A34),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            if (index == 2) {
              BlocProvider.of<HeroesBloc>(context).add(
                ProfileEvent(),
              );
            } else {
              BlocProvider.of<HeroesBloc>(context).add(
                RefreshEvent(),
              );
            }
          },
        ),
        body: BlocBuilder<HeroesBloc, HeroesState>(
          builder: (context, state) {
            if (state is Empty) {
              BlocProvider.of<HeroesBloc>(context).add(
                GetHeroesEvent(),
              );
              return const MessageDisplay(message: 'Loading app!');
            } else if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Loaded) {
              return PokemonsDisplay(
                favorites: _selectedIndex == 1 ? true : false,
                navBarKey: navBarKey,
              );
            } else if (state is Error) {
              return MessageDisplay(
                message: state.message,
              );
            } else if (state is Profile) {
              return const ProfileDisplay();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //Hive.close();
  }
}

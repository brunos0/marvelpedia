import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelpedia/core/services/auth_service.dart';
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
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  AuthService().logout();
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          key: navBarKey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? const Icon(
                      Icons.home_outlined,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.black,
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? const Icon(
                      Icons.person_outline_outlined,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
              label: 'Profile',
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
                GetHeroesEvent(increment: false),
              );
              return const SizedBox.shrink();
            } else if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Loaded) {
              return HeroesDisplay(
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
  }
}

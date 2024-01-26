import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_event.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_state.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/loading_widget.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/message_display.dart';
import 'package:pocketpedia/injection_container.dart';
import 'package:pocketpedia/pages/pokemons_display.dart';
import 'package:pocketpedia/pages/profile.dart';

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({super.key});

  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  int _selectedIndex = 0;
  final navBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        //
        providers: [
          BlocProvider<PokemonsBloc>(
            lazy: false,
            create: (_) => sl<PokemonsBloc>(),
          ),
          BlocProvider<DetailsBloc>(
            lazy: false,
            create: (_) => sl<DetailsBloc>(),
          )
        ],
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
                BlocProvider.of<PokemonsBloc>(context).add(
                  ProfileEvent(),
                );
              } else {
                BlocProvider.of<PokemonsBloc>(context).add(
                  RefreshEvent(),
                );
              }
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  BlocBuilder<PokemonsBloc, PokemonsState>(
                    builder: (context, state) {
                      if (state is Empty) {
                        BlocProvider.of<PokemonsBloc>(context)
                            .add(GetPokemonsEvent());
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
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

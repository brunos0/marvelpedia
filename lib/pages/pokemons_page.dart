import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_event.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_state.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/loading_widget.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/message_display.dart';
import 'package:pocketpedia/pages/pokemons_display.dart';
import 'package:pocketpedia/pages/profile.dart';

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({super.key});

  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFF10A34),
          onTap: (index) {
            _selectedIndex = index;

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
          //padding: const EdgeInsets.symmetric(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
/*
  BlocProvider<PokemonsBloc> buildBody(BuildContext context) {
    return 
  */

  // }

  @override
  void dispose() {
    super.dispose();
    //Hive.close();
  }
}

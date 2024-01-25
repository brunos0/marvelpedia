import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_event.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_state.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/loading_widget.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/message_display.dart';
import 'package:pocketpedia/injection_container.dart';
import 'package:pocketpedia/pages/pokemons_favorites_display.dart';
import 'package:pocketpedia/utils/navigator_controller.dart' as nav;

class PokemonsFavorites extends StatefulWidget {
  const PokemonsFavorites({super.key});

  @override
  State<PokemonsFavorites> createState() => _PokemonsFavoritesState();
}

class _PokemonsFavoritesState extends State<PokemonsFavorites> {
  int _selectedIndex = 1;
  int atualPage = 1;

  void _onItemTapped(int index) {
    /*
    setState(() {
      _selectedIndex = index;
    });
*/
    //BlocProvider.of<PokemonsBloc>(context).add(RefreshEvent());
    nav.onItemTapped(index, atualPage, context);
  }

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
          onTap: _onItemTapped,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SingleChildScrollView(child: buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  BlocProvider<PokemonsBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PokemonsBloc>(),
      // Top half
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<PokemonsBloc, PokemonsState>(
                builder: (context, state) {
                  if (state is Empty) {
                    BlocProvider.of<PokemonsBloc>(context)
                        .add(GetPokemonsEvent());
                    return const MessageDisplay(message: 'Loading app!');
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return PokemonsFavoritesDisplay();
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Hive.close();
  }
}

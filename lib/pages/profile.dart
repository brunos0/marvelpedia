import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_event.dart';
import 'package:pocketpedia/utils/navigator_controller.dart' as nav;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 2;
  int atualPage = 2;

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
            children: <Widget>[Text('teste')],
          ),
        ),
      ),
    );
  }
}

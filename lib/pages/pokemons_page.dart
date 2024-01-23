import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_event.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_state.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/loading_widget.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/message_display.dart';
import 'package:pocketpedia/injection_container.dart';
import 'package:pocketpedia/features/pokemon/presentation/widgets/pokemons_display.dart';

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({super.key});

  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'assets/popcorn.png',
                  width: 80,
                  height: 80,
                ),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Viva Videos!',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Seu Catálogo atualizado \n das novidades dos cinemas!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
            SingleChildScrollView(child: buildBody(context)),
          ],
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
                    return const MessageDisplay(
                        message: 'Retrieving pokemons list from Prof Oak!');
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return PokemonsDisplay(
                      pokemons: state.pokemons,
                    );
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
}

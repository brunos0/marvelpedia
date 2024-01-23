import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {
  const PokemonDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final (movieName, movieDescription, moviePoster) = ModalRoute.of(context)!
        .settings
        .arguments as (String, String, String); //Map<String, dynamic>;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: <Widget>[
        Image.network('https://image.tmdb.org/t/p/w500/$moviePoster'),
        Center(
          child: Text(
            movieName,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        const Divider(),
        const Text(
          'Overview',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          movieDescription,
          style: const TextStyle(fontSize: 15),
        ),
      ]),
    ));
  }
}

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: const Center(
          child: Column(
        children: [
          Text('Retrieving Pokemons list from Prof Oak!\nPlease Wait!'),
          CircularProgressIndicator(),
        ],
      )),
    );
  }
}

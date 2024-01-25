import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setAsset('assets/title.mp3');
      player.setLoopMode(LoopMode.one);
      player.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
          child: Column(
        children: [
          const Text('Retrieving Pokemons list from Prof Oak!'),
          const Text('Please Wait!'),
          const Gap(10),
          Image.asset(
            'assets/loading.gif',
            height: 100,
            width: 100,
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }
}

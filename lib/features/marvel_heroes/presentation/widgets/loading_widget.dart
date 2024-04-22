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
      await player.setAsset('assets/marvel_intro.mp3');
      player.setLoopMode(LoopMode.one);
      player.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.blue),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Retrieving Heroes list from Marvel Server!'),
          const Text('Please Wait!'),
          const Gap(10),
          Image.asset(
            'assets/marvel.gif',
            height: 300,
            width: 300,
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

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../utils/app_routes.dart';
import 'dart:async';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => IntroState();
}

class IntroState extends State<Intro> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/logo.mp4")
      ..initialize().then(
        (_) {
          setState(
            () {
              _controller.play();
            },
          );
        },
      ).then(
        (value) => Timer(
          const Duration(seconds: 3),
          () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.pokemonPage);
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

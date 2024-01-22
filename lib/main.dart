import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Custom Clipper')),
        body: Stack(children: [
          Center(
              child: ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
                height: 200,
                width: 380,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFCF47C),
                      Color(0xFFBC8905),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                )),
          )),
          Positioned(
            top: 310,
            left: 30,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/pokeball.png',
                  height: 140, width: 140, colorBlendMode: BlendMode.modulate),
            ),
          ),
          Positioned(
              top: 280,
              left: 40,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
                  //Image.asset(
                  //  'assets/pikachu.png',
                  height: 200,
                  width: 200,
                ),
              ))
        ]),
      ),
    ),
  );
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var radius = 40.0; // Ajuste o valor para alterar a curvatura

    path.moveTo(0, size.height - size.height * 0.75 + radius + 20);
    path.quadraticBezierTo(0, size.height - size.height * 0.75 + 20, radius,
        size.height - size.height * 0.78 + 20);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

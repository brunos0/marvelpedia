import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {
  const PokemonDetail({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    final (movieName, movieDescription, moviePoster) = ModalRoute.of(context)!
        .settings
        .arguments as (String, String, String); //Map<String, dynamic>;
*/
    return MaterialApp(
      home: SafeArea(
        child: DefaultTabController(
          initialIndex: 1,
          length: 4,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
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
                        SizedBox(
                          child: Opacity(
                            opacity: 0.1,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Image.asset('assets/pokeball.png',
                                    height: 140,
                                    width: 140,
                                    alignment: Alignment.bottomLeft,
                                    colorBlendMode: BlendMode.modulate),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60, right: 150),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: OverflowBox(
                              maxHeight: 180,
                              child: Image.network(
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
                                //Image.asset(
                                //  'assets/pikachu.png',
                                //height: 200,
                                //width: 200,
                                //alignment: Alignment.bottomLeft,
                                //fit: BoxFit.fill,

                                //scale: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TabBar(
                      indicatorColor: Colors.red,
                      labelColor: Colors.red,
                      tabs: <Widget>[
                        Text(
                          "About",
                        ),
                        Text('Stats'),
                        Text('Evolution'),
                        Text('Moves'),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBarView(
                        children: [
                          Container(
                            //height: 300,
                            //width: 300,
                            color: Colors.grey,
                          ),
                          Container(
                            //height: 300,
                            //width: 300,
                            color: Colors.grey,
                          ),
                          Container(
                            //height: 300,
                            //width: 300,
                            color: Colors.grey,
                          ),
                          Container(
                            //height: 300,
                            //width: 300,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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
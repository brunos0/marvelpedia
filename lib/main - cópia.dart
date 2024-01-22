import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Custom Clipper')),
      body: ClipPath(
        clipper: MyCustomClipper(),
        child: Container(
          height: 200,
          color: Colors.amber,
        ),
      ),
    ),
  ));
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.67); // 33% mais baixo do lado esquerdo
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height * 0.67); // borda superior direita
    path.lineTo(size.width, 0); // borda superior direita
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

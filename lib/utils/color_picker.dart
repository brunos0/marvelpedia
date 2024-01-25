import 'package:flutter/material.dart';

enum Types {
  grass(Color(0xFF1B932C)),
  poison(Color(0xFF8849B0)),
  fire(Color(0xFFF10A34)),
  flying(Color(0xFFAACBE1)),
  water(Color(0xFF265DFC)),
  normal(Color(0xFF7D3600)),
  electric(Color(0xFFF8A801)),
  ground(Color(0xFF673E2C)),
  fairy(Color(0xFFFF48CC)),
  bug(Color(0xFF54DC44)),
  fighting(Color(0xFF1E1815)),
  psychic(Color(0xFF6114BC)),
  rock(Color(0xFF54473D)),
  steel(Color(0xFF5D666E)),
  ice(Color(0xFF8FC3E9)),
  ghost(Color(0xFF8A8886)),
  dark(Color(0xFF000000)),
  dragon(Color(0xFF0804B4));

  final Color color;

  const Types(this.color);
}

Color colorTypePicker(String type) {
  final result = switch (type) {
    'grass' => Types.grass.color,
    'poison' => Types.poison.color,
    'fire' => Types.fire.color,
    'flying' => Types.flying.color,
    'water' => Types.water.color,
    'normal' => Types.normal.color,
    'electric' => Types.electric.color,
    'ground' => Types.ground.color,
    'fairy' => Types.fairy.color,
    'bug' => Types.bug.color,
    'fighting' => Types.fighting.color,
    'psychic' => Types.psychic.color,
    'rock' => Types.rock.color,
    'steel' => Types.steel.color,
    'ice' => Types.ice.color,
    'ghost' => Types.ghost.color,
    'dark' => Types.dark.color,
    'dragon' => Types.dragon.color,
    _ => const Color(0xFFFFFFFF), //blank
  };
  return result;
}

enum TypesBackground {
  grass(Color(0xFF70D090)),
  poison(Color(0xFFDDA1E7)),
  fire(Color(0xFFEC8C4C)),
  flying(Color(0xFFAACBE1)),
  water(Color(0xFF20C5F5)),
  normal(Color(0xFFFFE0CA)),
  electric(Color(0xFFFCF47C)),
  ground(Color(0xFF9E6E53)),
  fairy(Color(0xFFFDB7DA)),
  bug(Color(0xFFD0EC94)),
  fighting(Color(0xFFB8B8B8)),
  psychic(Color(0xFFA98DF8)),
  rock(Color(0xFF9A8371)),
  steel(Color(0xFF89A0B3)),
  ice(Color(0xFFB7DBFF)),
  ghost(Color(0xFFCDCDCD)),
  dark(Color(0xFF8D8ECB)),
  dragon(Color(0xFFAACBE1));

  final Color color;

  const TypesBackground(this.color);
}

Color colorTypeBackgroundPicker(String type) {
  final result = switch (type) {
    'grass' => TypesBackground.grass.color,
    'poison' => TypesBackground.poison.color,
    'fire' => TypesBackground.fire.color,
    'flying' => TypesBackground.flying.color,
    'water' => TypesBackground.water.color,
    'normal' => TypesBackground.normal.color,
    'electric' => TypesBackground.electric.color,
    'ground' => TypesBackground.ground.color,
    'fairy' => TypesBackground.fairy.color,
    'bug' => TypesBackground.bug.color,
    'fighting' => TypesBackground.fighting.color,
    'psychic' => TypesBackground.psychic.color,
    'rock' => TypesBackground.rock.color,
    'steel' => TypesBackground.steel.color,
    'ice' => TypesBackground.ice.color,
    'ghost' => TypesBackground.ghost.color,
    'dark' => TypesBackground.dark.color,
    'dragon' => TypesBackground.dragon.color,
    _ => const Color(0xFFFFFFFF), //blank
  };
  return result;
}

enum TypesBGFade {
  grass([
    Color(0xFF70D090),
    Color(0xFF55A23A),
  ]),
  poison([
    Color(0xFFDCBEE1),
    Color(0xFFDDA1E7),
  ]),
  fire([
    Color(0xFFEBB753),
    Color(0xFFC60000),
  ]),

  flying([
    Color(0xFFB2E1FF),
    Color(0xFFAACBE1),
  ]),
  water([
    Color(0xFF20C5F5),
    Color(0xFF157C9A),
  ]),
  normal([
    Color(0xFFFFF5EE),
    Color(0xFFFFE0CA),
  ]),
  electric([
    Color(0xFFFCF47C),
    Color(0xFFBC8905),
  ]),
  ground([
    Color(0xFFDA9871),
    Color(0xFF9E6E53),
  ]),
  fairy([
    Color(0xFFFCD6E9),
    Color(0xFFFDB7DA),
  ]),
  bug([
    Color(0xFFE6FFB1),
    Color(0xFFD0EC94),
  ]),
  fighting([
    Color(0xFFD7D7D7),
    Color(0xFFB8B8B8),
  ]),
  psychic([
    Color(0xFFBBA5F7),
    Color(0xFFA98DF8),
  ]),
  rock([
    Color(0xFFCEAF97),
    Color(0xFF9A8371),
  ]),
  steel([
    Color(0xFF9ABBD7),
    Color(0xFF89A0B3),
  ]),
  ice([
    Color(0xFFBACEE1),
    Color(0xFFB7DBFF),
  ]),

  ghost([
    Color(0xFFF0DADA),
    Color(0xFFCDCDCD),
  ]),
  dark([
    Color(0xFFADAEE6),
    Color(0xFF8D8ECB),
  ]),
  dragon([
    Color(0xFFC8E7FC),
    Color(0xFFAACBE1),
  ]);

  final List<Color> color;

  const TypesBGFade(this.color);
}

List<Color> colorTypeBGFadePicker(String type) {
  final result = switch (type) {
    'grass' => TypesBGFade.grass.color,
    'poison' => TypesBGFade.poison.color,
    'fire' => TypesBGFade.fire.color,
    'flying' => TypesBGFade.flying.color,
    'water' => TypesBGFade.water.color,
    'normal' => TypesBGFade.normal.color,
    'electric' => TypesBGFade.electric.color,
    'ground' => TypesBGFade.ground.color,
    'fairy' => TypesBGFade.fairy.color,
    'bug' => TypesBGFade.bug.color,
    'fighting' => TypesBGFade.fighting.color,
    'psychic' => TypesBGFade.psychic.color,
    'rock' => TypesBGFade.rock.color,
    'steel' => TypesBGFade.steel.color,
    'ice' => TypesBGFade.ice.color,
    'ghost' => TypesBGFade.ghost.color,
    'dark' => TypesBGFade.dark.color,
    'dragon' => TypesBGFade.dragon.color,
    _ => const [
        Color(0xFFFFFFFF),
        Color(0xFFFFFFFF),
      ] //blank
  };
  return result;
}

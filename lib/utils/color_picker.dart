import 'package:flutter/material.dart';

enum Types {
  grass(Color(0xFF1B932C)),
  poison(Color(0xFF8849B0)),
  fire(Color(0xFFF10A34)),
  flying(Color(0xFFAACBE1)),
  water(Color(0xFF265DFC)),
  normal(Color(0xFF7D3600)),
  eletric(Color(0xFFF8A801)),
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
    'eletric' => Types.eletric.color,
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
  poison(Color(0xFF8849B0)),
  fire(Color(0xFFEC8C4C)),
  flying(Color(0xFFAACBE1)),
  water(Color(0xFF20C5F5)),
  normal(Color(0xFF7D3600)),
  eletric(Color(0xFFF8A801)),
  ground(Color(0xFF673E2C)),
  fairy(Color(0xFFFF48CC)),
  bug(Color(0xFFD0EC94)),
  fighting(Color(0xFF1E1815)),
  psychic(Color(0xFF6114BC)),
  rock(Color(0xFF54473D)),
  steel(Color(0xFF5D666E)),
  ice(Color(0xFF8FC3E9)),
  ghost(Color(0xFF8A8886)),
  dark(Color(0xFF000000)),
  dragon(Color(0xFF0804B4));

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
    'eletric' => TypesBackground.eletric.color,
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

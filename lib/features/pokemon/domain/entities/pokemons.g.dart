// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonsAdapter extends TypeAdapter<Pokemons> {
  @override
  final int typeId = 1;

  @override
  Pokemons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemons(
      pokemons: (fields[0] as List).cast<Pokemon>(),
      step: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Pokemons obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pokemons)
      ..writeByte(1)
      ..write(obj.step);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 2;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      number: fields[0] as String,
      name: fields[1] as String,
    )
      ..description = fields[2] as String?
      ..height = fields[3] as double?
      ..weight = fields[4] as double?
      ..gender = fields[5] as String?
      ..category = fields[6] as String?
      ..stats = (fields[7] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          ?.toList()
      ..types = (fields[8] as List?)?.cast<String>()
      ..abilities = (fields[9] as List?)?.cast<String>()
      ..weakness = (fields[10] as List?)?.cast<String>()
      ..strengths = (fields[11] as List?)?.cast<String>()
      ..evolution = (fields[12] as List?)?.cast<String>()
      ..moves = (fields[13] as List?)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.stats)
      ..writeByte(8)
      ..write(obj.types)
      ..writeByte(9)
      ..write(obj.abilities)
      ..writeByte(10)
      ..write(obj.weakness)
      ..writeByte(11)
      ..write(obj.strengths)
      ..writeByte(12)
      ..write(obj.evolution)
      ..writeByte(13)
      ..write(obj.moves);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

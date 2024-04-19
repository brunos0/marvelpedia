// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heroes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeroesAdapter extends TypeAdapter<Heroes> {
  @override
  final int typeId = 1;

  @override
  Heroes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Heroes(
      heroes: (fields[0] as List).cast<Hero>(),
      step: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Heroes obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.heroes)
      ..writeByte(1)
      ..write(obj.step);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeroesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

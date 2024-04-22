// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeroAdapter extends TypeAdapter<Hero> {
  @override
  final int typeId = 2;

  @override
  Hero read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hero(
      id: fields[0] as int,
      name: fields[1] as String,
      profilePicture: fields[4] as String,
      comics: (fields[3] as List?)?.cast<dynamic>(),
      description: fields[2] as String?,
    )..favorite = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, Hero obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.comics)
      ..writeByte(4)
      ..write(obj.profilePicture)
      ..writeByte(5)
      ..write(obj.favorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeroAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

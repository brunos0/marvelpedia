import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'hero.g.dart';

@HiveType(typeId: 2)
class Hero extends HiveObject with EquatableMixin {
  Hero(
      {required this.id,
      required this.name,
      required this.profilePicture,
      required this.comics});

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  List? comics;
  @HiveField(4)
  final String profilePicture;
  @HiveField(5)
  bool favorite = false;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        comics,
        profilePicture,
        favorite,
      ];
}

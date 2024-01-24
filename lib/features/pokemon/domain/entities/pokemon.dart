import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 2)
class Pokemon extends Equatable {
  Pokemon({required this.number, required this.name});

  @HiveField(0)
  final String number;
  @HiveField(1)
  final String name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  double? height;
  @HiveField(4)
  double? weight;
  @HiveField(5)
  String? gender;
  @HiveField(6)
  String? category;
  @HiveField(7)
  List<Map<String, dynamic>>? stats;
  @HiveField(8)
  List<String>? types;
  @HiveField(9)
  List<String>? abilities;
  @HiveField(10)
  List<String>? weakness;
  @HiveField(11)
  List<String>? strengths;
  @HiveField(12)
  List<String>? evolution;
  @HiveField(13)
  List<String>? moves;

  @override
  List<Object?> get props => [
        number,
        name,
        description,
        height,
        weight,
        gender,
        category,
        types,
        abilities,
        weakness,
        strengths,
        stats,
        evolution,
        moves
      ];
}

import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  Pokemon({required this.number, required this.name});

  final String number;
  final String name;
  String? description;
  double? height;
  double? weight;
  String? gender;
  String? category;
  List<Map<String, dynamic>>? stats;
  List<String>? types;
  List<String>? abilities;
  List<String>? weakness;
  List<String>? strengths;
  List<String>? evolution;
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

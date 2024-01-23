import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  Pokemon({required this.number, required this.name});

  final String number;
  final String name;
  String? description;
  String? height;
  String? weight;
  String? gender;
  String? category;
  List<String>? abilities;
  List<String>? weakness;
  List<String>? streanghts;
  List<String>? stats;
  List<String>? evolution;
  List<String>? movies;

  @override
  List<Object?> get props => [
        number,
        name,
        description,
        height,
        weight,
        gender,
        category,
        abilities,
        weakness,
        streanghts,
        stats,
        evolution,
        movies
      ];
}

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/hero.dart';

part 'heroes.g.dart';

@HiveType(typeId: 1)
class Heroes extends HiveObject with EquatableMixin {
  Heroes({
    required this.heroes,
    this.step = 0,
  });

  @HiveField(0)
  final List<Hero> heroes;

  @HiveField(1)
  int step;

  @override
  List<Object?> get props => [heroes];
}

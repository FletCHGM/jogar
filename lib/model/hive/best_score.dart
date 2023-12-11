import 'package:hive_flutter/adapters.dart';

part 'best_score.g.dart';

@HiveType(typeId: 0)
class BestScore {
  BestScore({required this.bestScore});
  @HiveField(0)
  int bestScore;
}

late Box box;

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_score.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BestScoreAdapter extends TypeAdapter<BestScore> {
  @override
  final int typeId = 0;

  @override
  BestScore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BestScore(
      bestScore: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BestScore obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.bestScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BestScoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

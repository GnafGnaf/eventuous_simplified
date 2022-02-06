// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minesweeper_game_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinesweeperGameStarted _$MinesweeperGameStartedFromJson(
        Map<String, dynamic> json) =>
    MinesweeperGameStarted(
      id: json['id'] as String,
      minesAt: (json['minesAt'] as List<dynamic>)
          .map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MinesweeperGameStartedToJson(
        MinesweeperGameStarted instance) =>
    <String, dynamic>{
      'id': instance.id,
      'minesAt': instance.minesAt,
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      row: json['row'] as int,
      column: json['column'] as int,
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'row': instance.row,
      'column': instance.column,
    };

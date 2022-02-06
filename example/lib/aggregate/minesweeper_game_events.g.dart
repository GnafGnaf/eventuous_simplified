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
          .map((e) => FieldCoordinates.fromJson(e as Map<String, dynamic>))
          .toList(),
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$MinesweeperGameStartedToJson(
        MinesweeperGameStarted instance) =>
    <String, dynamic>{
      'id': instance.id,
      'minesAt': instance.minesAt,
      'width': instance.width,
      'height': instance.height,
    };

MinesweeperFieldRevealed _$MinesweeperFieldRevealedFromJson(
        Map<String, dynamic> json) =>
    MinesweeperFieldRevealed(
      row: json['row'] as int,
      column: json['column'] as int,
    );

Map<String, dynamic> _$MinesweeperFieldRevealedToJson(
        MinesweeperFieldRevealed instance) =>
    <String, dynamic>{
      'row': instance.row,
      'column': instance.column,
    };

MinesweeperGameLost _$MinesweeperGameLostFromJson(Map<String, dynamic> json) =>
    MinesweeperGameLost();

Map<String, dynamic> _$MinesweeperGameLostToJson(
        MinesweeperGameLost instance) =>
    <String, dynamic>{};

MinesweeperGameWon _$MinesweeperGameWonFromJson(Map<String, dynamic> json) =>
    MinesweeperGameWon();

Map<String, dynamic> _$MinesweeperGameWonToJson(MinesweeperGameWon instance) =>
    <String, dynamic>{};

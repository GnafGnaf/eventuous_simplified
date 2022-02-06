import 'package:freezed_annotation/freezed_annotation.dart';

part 'minesweeper_game_events.g.dart';

abstract class MinesweeperGameEvent {}

@JsonSerializable()
class MinesweeperGameStarted extends MinesweeperGameEvent {
  final String id;
  final List<Field> minesAt;

  MinesweeperGameStarted({required this.id, required this.minesAt});

  factory MinesweeperGameStarted.fromJson(Map<String, dynamic> json) =>
      _$MinesweeperGameStartedFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MinesweeperGameStartedToJson(this);
}

@JsonSerializable()
class Field {
  final int row;
  final int column;

  Field({required this.row, required this.column});

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

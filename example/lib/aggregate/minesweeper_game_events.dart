import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'minesweeper_game_events.g.dart';

@JsonSerializable()
class MinesweeperGameStarted extends Equatable {
  final String id;
  final List<Field> minesAt;

  MinesweeperGameStarted({required this.id, required this.minesAt});

  factory MinesweeperGameStarted.fromJson(Map<String, dynamic> json) =>
      _$MinesweeperGameStartedFromJson(json);

  @override
  List<Object?> get props => [id, minesAt];
}

@JsonSerializable()
class MinesweeperFieldRevealed extends Equatable {
  final int row, column;

  factory MinesweeperFieldRevealed.fromJson(Map<String, dynamic> json) =>
      _$MinesweeperFieldRevealedFromJson(json);

  MinesweeperFieldRevealed({required this.row, required this.column});

  @override
  List<Object?> get props => [row, column];
}

@JsonSerializable()
class MinesweeperGameLost extends Equatable {
  MinesweeperGameLost();
  factory MinesweeperGameLost.fromJson(Map<String, dynamic> json) =>
      _$MinesweeperGameLostFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class MinesweeperGameWon extends Equatable {
  MinesweeperGameWon();

  factory MinesweeperGameWon.fromJson(Map<String, dynamic> json) =>
      _$MinesweeperGameWonFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class Field extends Equatable {
  final int row, column;

  Field({required this.row, required this.column});

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  @override
  List<Object?> get props => [row, column];
}

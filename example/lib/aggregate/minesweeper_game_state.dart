import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:eventuous_simplified_example/value_object/field_coordinates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'minesweeper_game.dart';

part 'minesweeper_game_state.freezed.dart';

@freezed
class MinesweeperGameState
    with _$MinesweeperGameState, TypedIdState<MinesweeperGameId> {
  MinesweeperGameState._();

  factory MinesweeperGameState({
    required MinesweeperGameId? id,
    @Default([]) List<FieldCoordinates> minesAt,
    @Default([]) List<FieldCoordinates> revealedAt,
    required int width,
    required int height,
  }) = _MinesweeperGameState;

  factory MinesweeperGameState.initial() => MinesweeperGameState(
        id: null,
        minesAt: <FieldCoordinates>[],
        revealedAt: <FieldCoordinates>[],
        width: 0,
        height: 0,
      );

  static void changes(On<MinesweeperGameState> on) {
    on<MinesweeperGameStarted>(onGameStarted);
    on<MinesweeperFieldRevealed>(onFieldRevealed);
  }

  bool isMineAt({required int row, required int column}) {
    var cell = minesAt
        .firstWhereOrNull((cell) => cell.row == row && cell.column == column);

    if (cell == null) return false;

    return true;
  }

  bool areAllFieldsRevealed() {
    return revealedAt.length + minesAt.length == width * height;
  }

  static MinesweeperGameState onFieldRevealed(
    MinesweeperFieldRevealed event,
    MinesweeperGameState currentState,
  ) {
    return currentState.copyWith(
      revealedAt: [
        ...currentState.revealedAt,
        FieldCoordinates(column: event.column, row: event.row)
      ],
    );
  }

  static MinesweeperGameState onGameStarted(
    MinesweeperGameStarted event,
    MinesweeperGameState currentState,
  ) {
    return currentState.copyWith(
      id: MinesweeperGameId(event.id),
      minesAt: [
        for (final field in event.minesAt)
          FieldCoordinates(row: field.row, column: field.column)
      ],
      width: event.width,
      height: event.height,
    );
  }
}

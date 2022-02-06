import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:eventuous_simplified_example/value_object/mine_field.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'minesweeper_game.dart';

part 'minesweeper_game_state.freezed.dart';

@freezed
class MinesweeperGameState
    with _$MinesweeperGameState, TypedIdState<MinesweeperGameId> {
  MinesweeperGameState._();
  factory MinesweeperGameState({
    required MinesweeperGameId? id,
    @Default([]) List<Cell> minesAt,
  }) = _MinesweeperGameState;

  factory MinesweeperGameState.initial() => MinesweeperGameState(
        id: null,
        minesAt: <Cell>[],
      );

  static void changes(On<MinesweeperGameState> on) {
    on<MinesweeperGameStarted>(onGameStarted);
  }

  static MinesweeperGameState onGameStarted(
    MinesweeperGameStarted event,
    MinesweeperGameState currentState,
  ) {
    return currentState.copyWith(
      id: MinesweeperGameId(event.id),
      minesAt: [
        for (final field in event.minesAt)
          Cell(row: field.row, column: field.column).layMine()
      ],
    );
  }

  bool isMineAt({required int row, required int column}) {
    var cell = minesAt
        .firstWhereOrNull((cell) => cell.row == row && cell.column == column);

    if (cell == null) return false;

    return cell.isMine;
  }

  bool areAllFieldsRevealed() {
    return false; // TODO
  }
}

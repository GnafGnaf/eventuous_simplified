import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'minesweeper_game.dart';

part 'minesweeper_game_state.freezed.dart';

@freezed
class MinesweeperGameState
    with _$MinesweeperGameState, TypedIdState<MinesweeperGameId> {
  MinesweeperGameState._();
  factory MinesweeperGameState({
    required MinesweeperGameId? id,
    @Default([]) List<Field> minesAt,
  }) = _MinesweeperGameState;

  factory MinesweeperGameState.initial() => MinesweeperGameState(
        id: null,
        minesAt: <Field>[],
      );

  static void changes(On<MinesweeperGameState> on) {
    on<MinesweeperGameStarted>(onGameStarted);
  }

  static MinesweeperGameState onGameStarted(
    MinesweeperGameStarted event,
    MinesweeperGameState currentState,
  ) {
    return currentState.copyWith(id: MinesweeperGameId(event.id));
  }
}

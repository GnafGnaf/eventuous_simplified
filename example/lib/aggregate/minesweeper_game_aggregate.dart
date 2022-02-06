import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:eventuous_simplified_example/value_object/size.dart';

import '../value_object/mine_field.dart';
import 'minesweeper_game.dart';

class MinesweeperGameAggregate extends StatefulAggregate<MinesweeperGameState>
    with TypedId<MinesweeperGameState, MinesweeperGameId> {
  void startGame({int mineCount = 10, Size? size}) {
    ensureDoesntExist();

    size ??= Size.square(mineCount);

    final field = MineField.generate(mineCount: mineCount, size: size);

    apply(MinesweeperGameStarted(
      id: MinesweeperGameId.generate().toString(),
      minesAt: [
        for (final mine in field.mines)
          Field(row: mine.row, column: mine.column)
      ],
    ));
  }

  @override
  MinesweeperGameState createInitialState() => MinesweeperGameState.initial();

  @override
  void stateChanges(On<MinesweeperGameState> on) =>
      MinesweeperGameState.changes(on);

  void reveal({required int row, required int column}) {
    ensureExists();
    apply(MinesweeperFieldRevealed(row: row, column: column));

    if (currentState.data.isMineAt(row: row, column: column)) {
      apply(MinesweeperGameLost());
      return;
    }

    if (currentState.data.areAllFieldsRevealed()) {
      apply(MinesweeperGameWon());
    }
  }
}

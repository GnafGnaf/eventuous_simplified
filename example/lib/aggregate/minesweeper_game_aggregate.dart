import 'dart:math';

import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:eventuous_simplified_example/value_object/field_coordinates.dart';
import 'package:eventuous_simplified_example/value_object/size.dart';

import '../value_object/mine_field.dart';
import 'minesweeper_game.dart';

class MinesweeperGameAggregate extends StatefulAggregate<MinesweeperGameState>
    with TypedId<MinesweeperGameState, MinesweeperGameId> {
  @override
  MinesweeperGameState createInitialState() => MinesweeperGameState.initial();

  @override
  void stateChanges(On<MinesweeperGameState> on) =>
      MinesweeperGameState.changes(on);

  void startGame({int mineCount = 10, Size? size}) {
    ensureDoesntExist();

    size ??= Size.square(mineCount);
    var mines = _generateRandomMines(mineCount: mineCount, size: size);
    var id = MinesweeperGameId.generate().toString();

    apply(MinesweeperGameStarted(
      id: id,
      minesAt: [
        for (final mine in mines)
          FieldCoordinates(row: mine.row, column: mine.column)
      ],
      width: size.width,
      height: size.height,
    ));
  }

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

  static List<Cell> _generateRandomMines({
    required Size size,
    required int mineCount,
  }) {
    final fields = <Cell>[];

    for (var column = 0; column < size.width; column++) {
      for (var row = 0; row < size.height; row++) {
        fields.add(Cell(row: row, column: column));
      }
    }

    while (fields.length > mineCount) {
      fields.removeAt(Random().nextInt(fields.length));
    }

    return fields;
  }
}

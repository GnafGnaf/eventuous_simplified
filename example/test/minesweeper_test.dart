import 'package:eventuous_simplified_example/aggregate/minesweeper_game.dart';
import 'package:eventuous_simplified_example/value_object/field_coordinates.dart';
import 'package:test/test.dart';

void main() {
  group('starting a new game', () {
    test('generates a new id', () {
      final game = MinesweeperGameAggregate();
      game.startGame();
      expect(game.id, isNotEmpty);
    });

    test('generates a mine-field', () {
      final mineCount = 10;

      final game = MinesweeperGameAggregate();
      game.startGame(mineCount: 10);

      final createdEvent = game.changes.last as MinesweeperGameStarted;

      expect(createdEvent.minesAt, hasLength(mineCount));
    });
  });

  group('revealing a field', () {
    final gameStarted = MinesweeperGameStarted(
      id: MinesweeperGameId.generate().toString(),
      minesAt: [
        FieldCoordinates(row: 0, column: 1),
        FieldCoordinates(row: 1, column: 0),
        FieldCoordinates(row: 1, column: 1),
      ],
      width: 3,
      height: 3,
    );

    test('revealing an empty field', () {
      final game = MinesweeperGameAggregate();
      game.load([gameStarted]);

      game.reveal(row: 0, column: 0);

      expect(game.changes, [MinesweeperFieldRevealed(row: 0, column: 0)]);
    });

    test('revealing an mine', () {
      final game = MinesweeperGameAggregate();
      game.load([gameStarted]);

      game.reveal(row: 1, column: 1);
      expect(
        game.changes,
        [
          MinesweeperFieldRevealed(row: 1, column: 1),
          MinesweeperGameLost(),
        ],
      );
    });

    test('winning', () {
      final game = MinesweeperGameAggregate();
      game.load([gameStarted]);

      game.reveal(row: 0, column: 0);
      game.reveal(row: 0, column: 2);
      game.reveal(row: 1, column: 2);
      game.reveal(row: 2, column: 0);
      game.reveal(row: 2, column: 1);
      game.reveal(row: 2, column: 2);

      expect(
        game.changes.last,
        equals(MinesweeperGameWon()),
      );
    });
  });
}

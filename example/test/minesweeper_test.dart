import 'package:eventuous_simplified_example/aggregate/minesweeper_game.dart';
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
        Field(row: 1, column: 1),
        Field(row: 2, column: 0),
        Field(row: 2, column: 1),
      ],
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

    test('revealing the last mine', () {
      final game = MinesweeperGameAggregate();
      game.load([gameStarted]);

      game.reveal(row: 1, column: 1);
      expect(
        game.changes,
        [
          MinesweeperFieldRevealed(row: 1, column: 1),
          MinesweeperGameWon(),
        ],
      );
    });
  });
}

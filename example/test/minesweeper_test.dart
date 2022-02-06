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

      expect(game.currentState.data.minesAt, hasLength(mineCount));
    });
  });
}

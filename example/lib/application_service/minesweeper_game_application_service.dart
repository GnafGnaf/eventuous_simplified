import 'package:eventuous_simplified/eventuous_simplified.dart';

import '../aggregate/minesweeper_game.dart';

class MinesweeperGameApplicationService {
  final AggregateStore _aggregateStore;

  MinesweeperGameApplicationService(this._aggregateStore);

  startNewGame() async {
    final game = MinesweeperGameAggregate();
    game.startGame();
    await _aggregateStore.store(game);
  }

  revealField({
    required int row,
    required int column,
    required String gameId,
  }) async {
    final game = await _aggregateStore.load(gameId, MinesweeperGameAggregate());
    game.reveal(row: row, column: column);
    await _aggregateStore.store(game);
  }
}

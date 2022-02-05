import 'package:eventuous_simplified/eventuous_simplified.dart';

import '../aggregate/minesweeper_game.dart';

class MinesweeperGameApplicationService {
  final AggregateStore _aggregateStore;

  MinesweeperGameApplicationService(this._aggregateStore);

  startNewGame() {
    final game = MinesweeperGameAggregate();
    game.startGame();
    _aggregateStore.store(game);
  }
}

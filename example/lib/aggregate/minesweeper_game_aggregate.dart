import 'package:eventuous_simplified/eventuous_simplified.dart';

import 'minesweeper_game.dart';

class MinesweeperGameAggregate
    extends AggregateWithStateAndId<MinesweeperGameState, MinesweeperGameId> {
  MinesweeperGameAggregate()
      : super(initialState: MinesweeperGameState.initial());

  @override
  void registerEventHandlers(
    EventHandlerRegistry<MinesweeperGameState> registry,
  ) {}

  void startGame() {
    ensureDoesntExist();
    apply(MinesweeperGameStarted());
  }
}

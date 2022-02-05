import 'package:eventuous_simplified/eventuous_simplified.dart';

import 'minesweeper_game.dart';

class MinesweeperGameAggregate extends AggregateWithStateAndId<
    MinesweeperGameState, MinesweeperGameId, MinesweeperGameEvent> {
  MinesweeperGameAggregate()
      : super(initialState: MinesweeperGameState.initial());

  @override
  void registerEventHandlers(
    EventHandlerRegistry<MinesweeperGameState, MinesweeperGameEvent> registry,
  ) {}

  void startGame() {
    ensureDoesntExist();
    apply(MinesweeperGameStarted());
  }
}

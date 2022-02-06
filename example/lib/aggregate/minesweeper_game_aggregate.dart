import 'package:eventuous_simplified/eventuous_simplified.dart';

import 'minesweeper_game.dart';

class MinesweeperGameAggregate extends StatefulAggregate<MinesweeperGameState>
    with TypedId<MinesweeperGameState, MinesweeperGameId> {
  void startGame() {
    ensureDoesntExist();
    apply(MinesweeperGameStarted());
  }

  @override
  MinesweeperGameState createInitialState() => MinesweeperGameState.initial();

  @override
  void stateChanges(On<MinesweeperGameState> on) =>
      MinesweeperGameState.changes(on);
}

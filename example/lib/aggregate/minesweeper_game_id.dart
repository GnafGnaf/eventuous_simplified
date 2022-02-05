import 'package:uuid/uuid.dart';

class MinesweeperGameId {
  final String id;

  MinesweeperGameId(this.id);

  factory MinesweeperGameId.generate() => MinesweeperGameId(Uuid().v4());

  @override
  String toString() => id;
}

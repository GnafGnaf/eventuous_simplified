import 'package:eventuous_simplified/src/aggregate/stateful_aggregate.dart';

mixin TypedId<State extends TypedIdState<Id>, Id> on StatefulAggregate<State> {
  @override
  String get id {
    ensureExists();
    return currentState.data.id!.toString();
  }
}

mixin TypedIdState<Id> {
  Id? get id;
}

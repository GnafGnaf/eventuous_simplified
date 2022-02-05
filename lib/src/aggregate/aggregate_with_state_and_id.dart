import 'package:eventuous_simplified/src/aggregate/aggregate_library.dart';

abstract class AggregateWithStateAndId<State extends StateWithId<Id>, Id,
    Event extends DomainEvent> extends AggregateWithState<State, Event> {
  AggregateWithStateAndId({required State initialState})
      : super(initialState: initialState);

  @override
  String? get id {
    return currentState.data.id?.toString();
  }
}

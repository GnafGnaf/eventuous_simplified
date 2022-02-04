import 'aggregate_state.dart';
import 'aggregate_with_state.dart';

abstract class AggregateWithStateAndId<State extends StateWithId<Id>, Id, Event>
    extends AggregateWithState<State, Event> {
  AggregateWithStateAndId({required State initialState})
      : super(initialState: initialState);

  @override
  String? get id {
    return currentState.data.id?.toString();
  }
}

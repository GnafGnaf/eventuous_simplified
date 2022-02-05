import 'package:eventuous_simplified/src/aggregate/aggregate_library.dart';

abstract class AggregateWithStateAndId<State extends StateWithId<Id>, Id>
    extends AggregateWithState<State> {
  AggregateWithStateAndId({required State initialState})
      : super(initialState: initialState);

  @override
  String? get id {
    return currentState.data.id?.toString();
  }
}

import 'package:meta/meta.dart';

import 'aggregate_library.dart';

abstract class AggregateWithState<State, Event> extends Aggregate<Event> {
  final EventHandlerRegistry<State, Event> _registry = EventHandlerRegistry();

  final Versioned<State> initialState;

  @override
  int get currentVersion => currentState.version;

  @protected
  late Versioned<State> currentState = initialState;

  AggregateWithState({required State initialState})
      : initialState = Versioned(initialState) {
    registerEventHandlers(_registry);
  }

  void registerEventHandlers(EventHandlerRegistry<State, Event> registry);

  @override
  void fold(Event event) {
    currentState = currentState.incrementVersion(
      _registry.when(currentState.data, event),
    );
  }

  @override
  void load(List<Event> events) {
    for (final event in events) {
      fold(event);
    }
    originalVersion = currentState.version;
  }

  void apply(Event event) {
    addChange(event);
    fold(event);
  }
}

import 'package:meta/meta.dart';

import 'aggregate_library.dart';

abstract class AggregateWithState<State, Event> extends Aggregate {
  final EventHandlerRegistry<State, Event> _registry = EventHandlerRegistry();

  final Versioned<State> initialState;

  @override
  int get currentVersion => currentState.version;

  @protected
  @visibleForTesting
  late Versioned<State> currentState = initialState;

  AggregateWithState({required State initialState})
      : initialState = Versioned(initialState) {
    registerEventHandlers(_registry);
  }

  void registerEventHandlers(EventHandlerRegistry<State, Event> registry);

  @override
  void fold(Object event) {
    currentState = currentState.incrementVersion(
      _registry.when(currentState.data, event),
    );
  }

  @override
  void load(List<Object> events) {
    for (final event in events) {
      fold(event);
    }
    originalVersion = currentState.version;
  }

  void apply(Object event) {
    addChange(event);
    fold(event);
  }
}

import 'package:meta/meta.dart';

import 'aggregate_library.dart';

abstract class AggregateWithState<State> extends Aggregate {
  final EventHandlerRegistry<State> _registry = EventHandlerRegistry();

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

  void registerEventHandlers(EventHandlerRegistry<State> registry);

  @override
  void fold<T>(T event) {
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

  void apply<T>(T event) {
    addChange<T>(event);
    fold<T>(event);
  }
}

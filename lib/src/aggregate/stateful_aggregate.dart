import 'package:eventuous_simplified/src/aggregate/aggregate.dart';
import 'package:meta/meta.dart';

abstract class StatefulAggregate<State> extends AggregateBase {
  StatefulAggregate() {
    stateChanges(_registry.on);
  }

  void stateChanges(On<State> on);

  final EventHandlerRegistry<State> _registry = EventHandlerRegistry();

  @override
  int get currentVersion => currentState.version;

  @protected
  @visibleForTesting
  late Versioned<State> currentState = Versioned(createInitialState());

  @protected
  State createInitialState();

  @override
  void fold<Event extends Object>(Event event) {
    currentState = currentState.incrementVersion(
      _registry.when(event, currentState.data),
    );
  }

  @override
  void load(List<Object> events) {
    for (final event in events) {
      fold(event);
    }
    originalVersion = currentState.version;
  }

  void apply<Event extends Object>(Event event) {
    addChange<Event>(event);
    fold<Event>(event);
  }
}

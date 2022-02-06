typedef StateChange<Event extends Object, State> = State Function(
  Event event,
  State currentState,
);

typedef On<State> = void Function<Event extends Object>(
  StateChange<Event, State> stateChange,
);

class EventHandlerRegistry<State> {
  final Map<Type, StateChange<Object, State>> _handlers = {};

  void on<Event extends Object>(StateChange<Event, State> stateChange) {
    if (_handlers.containsKey(Event)) {
      throw ArgumentError(
        'Duplicate handler for event type $Event',
      );
    }
    _handlers[Event] =
        <E>(E event, currentState) => stateChange(event as Event, currentState);
  }

  State when<Event extends Object>(Event event, State currentState) {
    var handler = _handlers[Event];

    if (handler == null) {
      return currentState;
    }
    return handler(event, currentState);
  }
}

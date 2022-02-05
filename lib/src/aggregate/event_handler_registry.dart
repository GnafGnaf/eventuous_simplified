typedef EventHandler<State, Event> = State Function(
  State previousState,
  Event event,
);

class EventHandlerRegistry<State, Event> {
  final Map<Type, EventHandler<State, Event>> _handlers = {};

  on<T extends Event>(EventHandler<State, T> handler) {
    if (_handlers.containsKey(T)) {
      throw ArgumentError(
        'Duplicate handler for event type $T',
      );
    }
    _handlers[T] = (state, event) => handler(state, event as T);
  }

  State when(State currentState, Event event) {
    final eventType = event.runtimeType;
    var handler = _handlers[eventType];

    if (handler == null) {
      return currentState;
    }
    return handler(currentState, event);
  }
}

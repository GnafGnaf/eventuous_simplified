typedef EventHandler<State, Event> = State Function(
  State previousState,
  Event event,
);

class EventHandlerRegistry<State> {
  final Map<Type, EventHandler<State, Object>> _handlers = {};

  on<T extends Object>(EventHandler<State, T> handler) {
    if (_handlers.containsKey(T)) {
      throw ArgumentError(
        'Duplicate handler for event type $T',
      );
    }
    _handlers[T] = (previousState, event) => handler(previousState, event as T);
  }

  State when<T>(State currentState, T event) {
    var handler = _handlers[T] as EventHandler<State, T>?;

    if (handler == null) {
      return currentState;
    }
    return handler(currentState, event);
  }
}

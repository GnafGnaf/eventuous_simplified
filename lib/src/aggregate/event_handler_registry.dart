typedef EventHandler<State, Event> = State Function(
  State previousState,
  Event event,
);

Type typeOf<TAggregate>() => TAggregate;

class EventHandlerRegistry<State, Event> {
  final Map<Type, EventHandler<State, Event>> _handlers = {};

  on<T extends Event>(EventHandler<State, T> handler) {
    if (_handlers.containsKey(typeOf<T>())) {
      throw ArgumentError(
        'Duplicate handler for event type ${typeOf<Event>()}',
      );
    }
    _handlers[typeOf<T>()] = handler as EventHandler<State, Event>;
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

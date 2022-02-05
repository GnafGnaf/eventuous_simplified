abstract class EventSerializer<Event> {
  String serialize(Event event);
  Event deserialize(String serialized);
}

abstract class EventSerializer {
  Serialized serializeEvent<T>(T event);
  Object deserializeEvent(String data, String eventType);
  String get contentType;
}

class Serialized {
  final String eventType;
  final String payload;

  Serialized(this.eventType, this.payload);
}

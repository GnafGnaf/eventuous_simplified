import 'package:eventuous_simplified/src/serialization/event_serializer.dart';

class JsonEventSerializer<Event> implements EventSerializer<Event> {
  @override
  Event deserialize(String serialized) {
    throw UnimplementedError();
  }

  @override
  String serialize(Event event) {
    // TODO: implement serialize
    throw UnimplementedError();
  }
}

typedef Serializer<Event> = Event Function(Map<String, dynamic> json);
typedef Deserializer<Event> = Map<String, dynamic> Function(Event object);

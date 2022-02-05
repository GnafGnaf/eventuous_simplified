import 'dart:convert';

import 'package:eventuous_simplified/src/serialization/event_serializer.dart';
import 'package:eventuous_simplified/src/serialization/type_map.dart';

class JsonEventSerializers extends EventSerializer {
  final TypeMap typeMap;
  final Map<Type, JsonEventSerializer> _serializers;

  JsonEventSerializers({
    TypeMap? typeMap,
    required Map<Type, JsonEventSerializer> serializers,
  })  : typeMap = typeMap ?? TypeMap.instance(),
        _serializers = serializers;

  @override
  final contentType = 'application/json';

  @override
  Object deserializeEvent(String data, String eventType) {
    final json = jsonDecode(data);
    final type = typeMap.getType(eventType);
    return _serializers[type]!.fromJson(json);
  }

  @override
  Serialized serializeEvent<T>(T event) {
    final eventTypeName = typeMap.getTypeName(event);
    var eventType = typeMap.getType(eventTypeName);
    var serializer = _serializers[eventType] as JsonEventSerializer<T>?;
    final payload = jsonEncode(serializer!.toJson(event));
    return Serialized(eventTypeName, payload);
  }
}

class JsonEventSerializer<Event> {
  final ToJson<Event> toJson;
  final FromJson<Event> fromJson;

  JsonEventSerializer({required this.toJson, required this.fromJson});
}

typedef ToJson<Event> = Map<String, dynamic> Function(Event event);
typedef FromJson<Event> = Event Function(Map<String, dynamic> serialized);

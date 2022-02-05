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
  Serialized serializeEvent<T extends Object>(T event) {
    final typeOfEvent = event.runtimeType;
    final eventTypeName = typeMap.getNameForType(typeOfEvent);
    var serializer = _serializers[typeOfEvent];
    final payload = jsonEncode(serializer!.toJson(event));
    return Serialized(eventTypeName, payload);
  }
}

class JsonEventSerializer<Event extends Object> {
  final ToJson<Event> _toJson;
  final FromJson<Event> fromJson;

  JsonEventSerializer({required ToJson<Event> toJson, required this.fromJson})
      : _toJson = toJson;

  Map<String, dynamic> toJson(Object event) => _toJson(event as Event);
}

typedef ToJson<Event> = Map<String, dynamic> Function(Event event);
typedef FromJson<Event> = Event Function(Map<String, dynamic> serialized);

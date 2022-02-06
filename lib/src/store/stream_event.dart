import 'package:eventuous_simplified/eventuous_simplified.dart';

class StreamEvent {
  final Serialized serializedEvent;
  final String contentType;
  final int position;

  StreamEvent({
    required this.serializedEvent,
    required this.contentType,
    required this.position,
  });
}

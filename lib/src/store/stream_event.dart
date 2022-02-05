class StreamEvent {
  final Object? payload;
  final String contentType;
  final int position;

  StreamEvent({
    required this.payload,
    required this.contentType,
    required this.position,
  });
}

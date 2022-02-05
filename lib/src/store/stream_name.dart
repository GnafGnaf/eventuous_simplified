class StreamName {
  final String value;

  StreamName(this.value) {
    if (value.isEmpty) throw InvalidStreamName(value);
  }

  static StreamName forId<T>(String entityId) {
    if (entityId.isEmpty) throw InvalidStreamName('empty entityId');
    return StreamName('$T--$entityId');
  }

  @override
  String toString() => value;
}

class InvalidStreamName implements Exception {
  final String message;

  InvalidStreamName(this.message);
}

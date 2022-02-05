import 'package:equatable/equatable.dart';

class StreamName extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props => [value];
}

class InvalidStreamName implements Exception {
  final String message;

  InvalidStreamName(this.message);
}

import 'package:meta/meta.dart';

@immutable
abstract class DomainEvent<T> {
  String serialize();
  T deserialize(String serialized);
}

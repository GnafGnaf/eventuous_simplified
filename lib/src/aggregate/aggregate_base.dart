import 'package:meta/meta.dart';

import '../exceptions/exceptions.dart';

abstract class AggregateBase {
  final _changes = <Object>[];

  List<Object> get changes => [..._changes];
  void clearChanges() => _changes.clear();

  int originalVersion = -1;
  int currentVersion = -1;

  void load(List<Object> events);
  void fold<Event extends Object>(Event event);

  String get id;

  @protected
  void addChange<T>(T event) => _changes.add(event as Object);

  @protected
  void ensureDoesntExist({void Function()? orElse}) {
    if (currentVersion > -1) {
      orElse != null
          ? orElse()
          : throw DomainException('$runtimeType already exists: $id');
    }
  }

  @protected
  ensureExists({void Function()? orElse}) {
    if (currentVersion == -1) {
      orElse != null
          ? orElse()
          : throw DomainException('$runtimeType doesn\'t exists.');
    }
  }
}

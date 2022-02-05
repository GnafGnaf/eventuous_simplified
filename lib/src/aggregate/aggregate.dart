import 'package:meta/meta.dart';

import '../exceptions/exceptions.dart';

abstract class Aggregate {
  final _changes = [];

  List<Object> get changes => [..._changes];
  void clearChanges() => _changes.clear();

  int originalVersion = -1;
  int currentVersion = -1;

  void load(List<Object> events);
  void fold(Object event);

  String? get id;

  @protected
  void addChange(Object event) => _changes.add(event);

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
          : throw DomainException('$runtimeType doesn\'t exists: $id');
    }
  }
}

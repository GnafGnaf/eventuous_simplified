import 'package:eventuous_simplified/src/exceptions/unregistered_type_exception.dart';

class TypeMap {
  static TypeMap? _instance;
  final Map<String, Type> _nameToType = {};
  final Map<Type, String> _typeToName = {};

  TypeMap._();
  factory TypeMap.instance() {
    _instance ??= TypeMap._();
    return _instance!;
  }

  void addType<T>(String name) {
    _typeToName[T] = name;
    _nameToType[name] = T;
  }

  bool isTypeRegistered<T>() {
    return _typeToName.containsKey(T);
  }

  String getTypeName<T>([T? object]) {
    var name = _typeToName[T];
    if (name == null) {
      throw UnregisteredTypeException.fromType(T);
    }
    return name;
  }

  Type getType(String name) {
    var type = _nameToType[name];
    if (type == null) {
      throw UnregisteredTypeException.fromTypeName(name);
    }
    return type;
  }
}

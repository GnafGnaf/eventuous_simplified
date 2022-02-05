import 'package:equatable/equatable.dart';

class UnregisteredTypeException extends Equatable implements Exception {
  final String message;
  UnregisteredTypeException._(this.message);
  factory UnregisteredTypeException.fromType(Type type) =>
      UnregisteredTypeException._(
          'Type $type is not registered in the type map');

  factory UnregisteredTypeException.fromTypeName(String typeName) =>
      UnregisteredTypeException._(
          "Type name $typeName is not registered in the type map");

  @override
  List<Object?> get props => [message];
}

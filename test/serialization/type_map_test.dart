import 'package:eventuous_simplified/src/exceptions/unregistered_type_exception.dart';
import 'package:eventuous_simplified/src/serialization/type_map.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    TypeMap.instance().addType<Type1>('type_1');
    TypeMap.instance().addType<Type2>('type_2');
    TypeMap.instance().addType<Type21>('type_2_1');
  });

  test('is a singleton', () {
    expect(TypeMap.instance(), same(TypeMap.instance()));
  });

  test('gives name of type', () {
    expect(TypeMap.instance().getTypeName<Type1>(), 'type_1');
    expect(TypeMap.instance().getTypeName<Type2>(), 'type_2');
    expect(TypeMap.instance().getTypeName<Type21>(), 'type_2_1');
  });

  test('gives type name of object', () {
    final type1 = Type1();
    final type2 = Type2();
    final type21 = Type21();

    expect(TypeMap.instance().getTypeName(type1), 'type_1');
    expect(TypeMap.instance().getTypeName(type2), 'type_2');
    expect(TypeMap.instance().getTypeName(type21), 'type_2_1');
  });

  test('knows if type is registered', () {
    expect(TypeMap.instance().isTypeRegistered<Type1>(), isTrue);
    expect(TypeMap.instance().isTypeRegistered<Type3>(), isFalse);
  });

  test('gives type for type name', () {
    expect(TypeMap.instance().getType('type_1'), equals(Type1));
    expect(TypeMap.instance().getType('type_2'), equals(Type2));
    expect(TypeMap.instance().getType('type_2_1'), equals(Type21));
  });

  test('throws for unregistered', () {
    expect(() => TypeMap.instance().getType('type_3'),
        throwsA(isA<UnregisteredTypeException>()));
    expect(() => TypeMap.instance().getTypeName(Type3()),
        throwsA(isA<UnregisteredTypeException>()));
  });
}

class Type1 {}

class Type2 {}

class Type21 extends Type2 {}

class Type3 {}

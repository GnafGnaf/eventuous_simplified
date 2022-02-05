import 'package:equatable/equatable.dart';
import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:test/test.dart';

void main() {
  late JsonEventSerializers serializer;

  setUp(() {
    final typeMap = TypeMap.instance();
    typeMap.addType<Serializable>('serializable');
    serializer = JsonEventSerializers(typeMap: typeMap, serializers: {
      Serializable: JsonEventSerializer<Serializable>(
        toJson: (serializable) => serializable.toJson(),
        fromJson: Serializable.fromJson,
      ),
    });
  });

  tearDown(() {
    TypeMap.instance().dispose();
  });

  test('serialization', () {
    final serializable = Serializable('Test');

    final serialized = serializer.serializeEvent(serializable);
    final rehydrated = serializer.deserializeEvent(
      serialized.payload,
      serialized.eventType,
    );

    expect(serializable, equals(rehydrated));
  });
}

class Serializable extends Equatable {
  final String test;

  Serializable(this.test);

  factory Serializable.fromJson(Map<String, dynamic> json) {
    return Serializable(json['test']);
  }

  Map<String, dynamic> toJson() {
    return {'test': test};
  }

  @override
  List<Object?> get props => [test];
}

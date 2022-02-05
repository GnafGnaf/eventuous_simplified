import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:eventuous_simplified/src/store/in_memory_event_store.dart';
import 'package:test/test.dart';

void main() {
  late AggregateStore aggregateStore;

  setUp(() {
    final typeMap = TypeMap.instance();
    typeMap.addType<TestCreated>('test_created');
    final eventStore = InMemoryEventStore();
    final eventSerializer = JsonEventSerializers(
      serializers: {
        TestCreated: JsonEventSerializer<TestCreated>(
          toJson: (event) => event.toJson(),
          fromJson: TestCreated.fromJson,
        )
      },
      typeMap: typeMap,
    );

    aggregateStore = AggregateStore(eventStore, eventSerializer);
  });

  tearDown(() {
    TypeMap.instance().dispose();
  });

  group('store an aggregate', () {
    test('without changes we get no op', () {});
  });
}

class TestCreated {
  final String test;

  TestCreated(this.test);

  factory TestCreated.fromJson(Map<String, dynamic> json) {
    return TestCreated(json['test']);
  }

  Map<String, dynamic> toJson() {
    return {'test': test};
  }
}

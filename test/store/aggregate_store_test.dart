import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:eventuous_simplified/src/store/in_memory_event_store.dart';
import 'package:eventuous_simplified/src/store/store.dart';
import 'package:test/test.dart';

void main() {
  late AggregateStore aggregateStore;
  late InMemoryEventStore eventStore;

  setUp(() {
    final typeMap = TypeMap.instance();
    typeMap.addType<TestCreated>('test_created');
    eventStore = InMemoryEventStore();
    final eventSerializer = JsonEventSerializers(
      serializers: {
        TestCreated: JsonEventSerializer<TestCreated>(
          toJson: (event) => (event as TestCreated).toJson(),
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
    test('without changes we get no op', () async {
      final result = await aggregateStore.store(TestAggregate());
      expect(result, equals(AppendEventsResult.noOp()));
    });

    test('saves changes', () async {
      var testAggregate = TestAggregate();
      testAggregate.testCreated('test');

      final stream = StreamName.forId<TestAggregate>(testAggregate.id);

      await aggregateStore.store(testAggregate);

      expect(
        eventStore.readEvents(stream, StreamReadPosition(0), 99),
        equals([TestCreated('test')]),
      );
    });

    test('optimistic concurrency', () {});
  });
}

class TestAggregate extends AggregateWithState<AggregateState> {
  TestAggregate() : super(initialState: AggregateState());

  @override
  String get id => '42';

  @override
  void registerEventHandlers(EventHandlerRegistry<AggregateState> registry) {}

  void testCreated(String testString) {
    ensureDoesntExist();
    apply(TestCreated(testString));
  }
}

class AggregateId {}

class AggregateState {}

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

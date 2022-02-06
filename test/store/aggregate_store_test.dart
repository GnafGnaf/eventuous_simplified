import 'package:equatable/equatable.dart';
import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:eventuous_simplified/src/store/in_memory_event_store.dart';
import 'package:eventuous_simplified/src/store/store.dart';
import 'package:test/test.dart';

void main() {
  late AggregateStore aggregateStore;
  late InMemoryEventStore eventStore;
  late JsonEventSerializers serializers;

  setUp(() {
    final typeMap = TypeMap.instance();
    typeMap.addType<TestCreated>('test_created');
    eventStore = InMemoryEventStore();
    serializers = JsonEventSerializers(
      serializers: {
        TestCreated: JsonEventSerializer<TestCreated>(
          toJson: (event) => event.toJson(),
          fromJson: TestCreated.fromJson,
        )
      },
      typeMap: typeMap,
    );

    aggregateStore = AggregateStore(eventStore, serializers);
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

      final savedEvents = await eventStore.readEvents(
        stream,
        StreamReadPosition(0),
        99,
      );

      final payload = savedEvents.single.payload as Serialized;

      final savedEvent =
          serializers.deserializeEvent(payload.payload, payload.eventType);

      expect(
        savedEvent,
        equals(TestCreated('test')),
      );
    });

    test('optimistic concurrency', () async {
      var testAggregate = TestAggregate();
      testAggregate.testCreated('test');

      var conflicting = TestAggregate();
      conflicting.testCreated('test');

      await aggregateStore.store(testAggregate);

      expect(
        () async => aggregateStore.store(conflicting),
        throwsA(
          isA<Exception>(),
        ),
      );
    });
  });
}

class TestAggregate extends StatefulAggregate<AggregateState>
    with TypedId<AggregateState, AggregateId> {
  @override
  String get id => '42';

  void testCreated(String testString) {
    ensureDoesntExist();
    apply(TestCreated(testString));
  }

  @override
  AggregateState createInitialState() => AggregateState();

  @override
  void stateChanges(On<AggregateState> on) => AggregateState.changes(on);
}

class AggregateId {}

class AggregateState with TypedIdState<AggregateId> {
  @override
  AggregateId? get id => AggregateId();

  static changes(On<AggregateState> on) {}
}

class TestCreated extends Equatable {
  final String test;

  TestCreated(this.test);

  factory TestCreated.fromJson(Map<String, dynamic> json) {
    return TestCreated(json['test']);
  }

  Map<String, dynamic> toJson() {
    return {'test': test};
  }

  @override
  List<Object?> get props => [test];
}

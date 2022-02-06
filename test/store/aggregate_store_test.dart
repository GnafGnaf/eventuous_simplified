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
      testAggregate.testCreated('test', AggregateId('testId'));

      final stream = StreamName.forId<TestAggregate>(testAggregate.id);

      await aggregateStore.store(testAggregate);

      final savedEvents = await eventStore.readEvents(
        stream,
        StreamReadPosition(0),
        99,
      );

      final payload = savedEvents.single.serializedEvent as Serialized;

      final savedEvent =
          serializers.deserializeEvent(payload.payload, payload.eventType);

      expect(
        savedEvent,
        equals(TestCreated('test', 'testId')),
      );
    });

    test('optimistic concurrency', () async {
      var testAggregate = TestAggregate();
      testAggregate.testCreated('test', AggregateId('testId'));

      var conflicting = TestAggregate();
      conflicting.testCreated('test', AggregateId('testId'));

      await aggregateStore.store(testAggregate);

      expect(
        () async => aggregateStore.store(conflicting),
        throwsA(
          isA<Exception>(),
        ),
      );
    });
  });

  group('load', () {
    test('load a saved instance', () async {
      final testAggregate = TestAggregate();
      testAggregate.testCreated('testme123', AggregateId('testId'));
      await aggregateStore.store(testAggregate);

      final loaded =
          await aggregateStore.load(testAggregate.id, TestAggregate());

      expect(loaded.currentState.data, equals(testAggregate.currentState.data));
      expect(
        loaded.currentState.version,
        equals(testAggregate.currentState.version),
      );
    });
  });
}

class TestAggregate extends StatefulAggregate<AggregateState>
    with TypedId<AggregateState, AggregateId> {
  void testCreated(String testString, AggregateId testId) {
    ensureDoesntExist();
    apply(TestCreated(testString, testId.toString()));
  }

  @override
  AggregateState createInitialState() => AggregateState();

  @override
  void stateChanges(On<AggregateState> on) => AggregateState.changes(on);
}

class AggregateId extends Equatable {
  final String value;

  AggregateId(this.value);

  @override
  String toString() => value;

  @override
  List<Object?> get props => [value];
}

class AggregateState extends Equatable with TypedIdState<AggregateId> {
  final String testString;

  AggregateState({this.testString = '', this.id});

  @override
  final AggregateId? id;

  static changes(On<AggregateState> on) {
    on<TestCreated>(onTestCreated);
  }

  static AggregateState onTestCreated(
      TestCreated event, AggregateState currentState) {
    return AggregateState(
      testString: event.test,
      id: AggregateId(event.id),
    );
  }

  @override
  List<Object?> get props => [id, testString];
}

class TestCreated extends Equatable {
  final String test;

  final String id;

  TestCreated(this.test, this.id);

  factory TestCreated.fromJson(Map<String, dynamic> json) {
    return TestCreated(json['test'], json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'test': test, 'id': id};
  }

  @override
  List<Object?> get props => [test, id];
}

import 'package:eventuous_simplified/eventuous_simplified.dart'
    show AggregateBase;
import 'package:eventuous_simplified/src/aggregate/aggregate.dart';
import 'package:eventuous_simplified/src/serialization/event_serializer.dart';
import 'package:eventuous_simplified/src/store/store.dart';

import 'store.dart';

class AggregateStore {
  final EventStore _eventStore;
  final EventSerializer _eventSerializer;

  AggregateStore(this._eventStore, this._eventSerializer);

  Future<AppendEventsResult> store<T extends AggregateBase>(T aggregate) async {
    if (aggregate.changes.isEmpty) {
      return AppendEventsResult.noOp();
    }

    final streamName = StreamName.forId<T>(aggregate.id);
    final expectedStreamVersion = ExpectedStreamVersion(
      aggregate.originalVersion,
    );

    return _eventStore.appendEvents(
      streamName,
      expectedStreamVersion,
      [
        ...aggregate.changes.map(
          (change) {
            return StreamEvent(
              serializedEvent: _eventSerializer.serializeEvent(change),
              contentType: _eventSerializer.contentType,
              position: -1,
            );
          },
        ),
      ],
    );
  }

  // Todo: create aggregate factory so i don't have to change a parameter
  Future<Aggregate> load<Aggregate extends AggregateBase>(
    String id,
    Aggregate aggregate,
  ) async {
    final streamName = StreamName.forId<Aggregate>(id);

    final batchCount = 0;
    final batchSize = 500;
    while (true) {
      final events = await _eventStore.readEvents(
        streamName,
        StreamReadPosition(batchCount * batchSize),
        batchSize,
      );

      aggregate.load([
        for (final event in events)
          _eventSerializer.deserializeEvent(
            event.serializedEvent.payload,
            event.serializedEvent.eventType,
          )
      ]);

      if (events.length < batchSize) {
        break;
      }
    }

    return aggregate;
  }
}

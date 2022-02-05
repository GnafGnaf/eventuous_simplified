import 'package:eventuous_simplified/eventuous_simplified.dart' show Aggregate;
import 'package:eventuous_simplified/src/serialization/event_serializer.dart';
import 'package:eventuous_simplified/src/store/store.dart';

import 'store.dart';

class AggregateStore {
  final EventStore _eventStore;
  final EventSerializer _eventSerializer;

  AggregateStore(this._eventStore, this._eventSerializer);

  Future<AppendEventsResult> store<T extends Aggregate>(T aggregate) async {
    if (aggregate.changes.isEmpty) {
      return AppendEventsResult.noOp();
    }

    final streamName = StreamName.forId<T>(aggregate.id ?? '');
    final expectedStreamVersion = ExpectedStreamVersion(
      aggregate.originalVersion,
    );

    _eventStore.appendEvents(
      streamName,
      expectedStreamVersion,
      _toStreamEvents(aggregate.changes),
    );

    return AppendEventsResult.noOp();
  }

  Iterable<StreamEvent> _toStreamEvents(List<Object> events) {
    return [
      for (final event in events)
        StreamEvent(
          payload: _eventSerializer.serializeEvent(event),
          contentType: _eventSerializer.contentType,
          position: -1,
        ),
    ];
  }
}

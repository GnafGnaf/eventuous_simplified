import 'package:eventuous_simplified/eventuous_simplified.dart'
    show AggregateBase;
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
              payload: _eventSerializer.serializeEvent(change),
              contentType: _eventSerializer.contentType,
              position: -1,
            );
          },
        ),
      ],
    );
  }
}

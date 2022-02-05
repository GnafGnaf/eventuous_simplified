import 'package:eventuous_simplified/src/store/store.dart';

abstract class EventStore {
  Future<bool> isStreamExisting(StreamName streamName);
  Future<AppendEventsResult> appendEvents(
    StreamName streamName,
    ExpectedStreamVersion expectedStreamVersion,
    Iterable<StreamEvent> events,
  );

  Future<List<StreamEvent>> readEvents(
    StreamName streamName,
    StreamReadPosition start,
    int count,
  );
}

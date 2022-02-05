import 'package:eventuous_simplified/src/store/append_events_result.dart';
import 'package:eventuous_simplified/src/store/event_store.dart';
import 'package:eventuous_simplified/src/store/expected_stream_version.dart';
import 'package:eventuous_simplified/src/store/stream_event.dart';
import 'package:eventuous_simplified/src/store/stream_name.dart';

class InMemoryEventStore implements EventStore {
  @override
  Future<AppendEventsResult> appendEvents(
    StreamName streamName,
    ExpectedStreamVersion expectedStreamVersion,
    Iterable<StreamEvent> events,
  ) {
    // TODO: implement appendEvents
    throw UnimplementedError();
  }

  @override
  Future<bool> isStreamExisting(StreamName streamName) {
    // TODO: implement isStreamExisting
    throw UnimplementedError();
  }

  @override
  Future<List<StreamEvent>> readEvents(
      StreamName streamName, StreamReadPosition start, int count) {
    // TODO: implement readEvents
    throw UnimplementedError();
  }
}

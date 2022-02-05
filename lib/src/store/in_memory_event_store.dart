import 'dart:math';

import 'package:eventuous_simplified/src/store/append_events_result.dart';
import 'package:eventuous_simplified/src/store/event_store.dart';
import 'package:eventuous_simplified/src/store/expected_stream_version.dart';
import 'package:eventuous_simplified/src/store/stream_event.dart';
import 'package:eventuous_simplified/src/store/stream_name.dart';

class InMemoryEventStore implements EventStore {
  final Map<StreamName, List<StreamEvent>> _streams = {};
  List<StreamEvent> _allEvents = [];

  @override
  Future<AppendEventsResult> appendEvents(
    StreamName streamName,
    ExpectedStreamVersion expectedStreamVersion,
    Iterable<StreamEvent> events,
  ) async {
    final stream = _streams[streamName] ?? [];
    final version = stream.length - 1;

    if (expectedStreamVersion.version != version) {
      throw Exception('Wrong version'); // tODO: better exception
    }

    _streams[streamName] = [...stream, ...events];
    _allEvents = [..._allEvents, ...events];

    return AppendEventsResult(
      _allEvents.length - 1,
      _streams[streamName]!.length - 1,
    );
  }

  @override
  Future<bool> isStreamExisting(StreamName streamName) async =>
      _streams.containsKey(streamName);

  @override
  Future<List<StreamEvent>> readEvents(
    StreamName streamName,
    StreamReadPosition start,
    int count,
  ) async {
    final stream = _streams[streamName] ?? [];
    return stream.sublist(
      start.value,
      min(start.value + count, stream.length),
    );
  }
}

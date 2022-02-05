import 'package:equatable/equatable.dart';

class AppendEventsResult extends Equatable {
  final int globalPosition;
  final int nextExpectedVersion;

  const AppendEventsResult(
    this.globalPosition,
    this.nextExpectedVersion,
  );

  const AppendEventsResult.noOp()
      : globalPosition = 0,
        nextExpectedVersion = -1;

  @override
  List<Object?> get props => [globalPosition, nextExpectedVersion];
}

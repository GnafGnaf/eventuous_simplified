class AppendEventsResult {
  final int globalPosition;
  final int nextExpectedVersion;

  const AppendEventsResult(
    this.globalPosition,
    this.nextExpectedVersion,
  );

  const AppendEventsResult.noOp()
      : globalPosition = 0,
        nextExpectedVersion = -1;
}

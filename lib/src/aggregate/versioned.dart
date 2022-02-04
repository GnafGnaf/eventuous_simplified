class Versioned<T> {
  final T data;
  final int version;

  Versioned._(this.data, this.version);

  Versioned(T initialData)
      : data = initialData,
        version = -1;

  Versioned<T> incrementVersion(T data) {
    return Versioned._(data, version + 1);
  }
}

library eventuous_simplified;

export 'src/aggregate/aggregate.dart'
    show
        AggregateBase,
        StatefulAggregate,
        StatelessAggregate,
        TypedId,
        TypedIdState,
        On;
export 'src/serialization/serialization.dart'
    show
        JsonEventSerializers,
        JsonEventSerializer,
        TypeMap,
        Serialized,
        EventSerializer;
export 'src/store/store.dart' show AggregateStore;

import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:test/test.dart';

void main() {
  test('new events are added to changes', () {
    final aggregate = BookingAggregate();
    aggregate.book(12);

    expect(aggregate.changes, equals([Booked(bookingId: 'anId', price: 12)]));
  });

  test('the state gets updated', () {
    final aggregate = BookingAggregate();
    aggregate.book(12);

    expect(
      aggregate.currentState,
      equals(BookingState(id: BookingId('anId'), price: 12)),
    );
  });
}

class BookingAggregate
    extends AggregateWithStateAndId<BookingState, BookingId, BookingEvent> {
  BookingAggregate() : super(initialState: BookingState.initial());

  @override
  void registerEventHandlers(
    EventHandlerRegistry<BookingState, BookingEvent> registry,
  ) {
    registry.on<Booked>(
      (previousState, event) => previousState.onBooked(event),
    );
    registry.on<Imported>(
      (previousState, event) => previousState.onImported(event),
    );
  }

  book(int price) {
    ensureDoesntExist();
    apply(Booked(bookingId: 'anId', price: 20));
  }

  import(String id) {
    ensureDoesntExist();
    apply(Imported(bookingId: id));
  }
}

abstract class BookingEvent {}

class Booked extends BookingEvent {
  final String bookingId;
  final int price;

  Booked({required this.bookingId, required this.price});
}

class Imported extends BookingEvent {
  final String bookingId;

  Imported({required this.bookingId});
}

class BookingId {
  final String id;

  BookingId(this.id);

  @override
  String toString() => id;
}

class BookingState implements StateWithId<BookingId> {
  @override
  final BookingId? id;
  final int price;

  BookingState({required this.id, required this.price});

  factory BookingState.initial() => BookingState(id: null, price: 0);

  BookingState copyWith({BookingId? id, int? price}) {
    return BookingState(id: id ?? this.id, price: price ?? this.price);
  }

  BookingState onBooked(Booked event) =>
      copyWith(id: BookingId(event.bookingId), price: event.price);

  BookingState onImported(Imported event) =>
      copyWith(id: BookingId(event.bookingId));
}

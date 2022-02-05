import 'package:equatable/equatable.dart';
import 'package:eventuous_simplified/eventuous_simplified.dart';
import 'package:eventuous_simplified/src/exceptions/domain_exception.dart';
import 'package:meta/meta.dart';
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
      aggregate.currentState.data,
      equals(BookingState(id: BookingId('anId'), price: 12)),
    );
  });

  test('the state is versioned', () {
    final aggregate = BookingAggregate();
    expect(aggregate.currentState.version, equals(-1));

    aggregate.book(12);

    expect(
      aggregate.currentState.version,
      equals(0),
    );
  });

  test('checks if exists', () {
    final aggregate = BookingAggregate();
    aggregate.book(12);
    expect(() => aggregate.book(23), throwsA(isA<DomainException>()));
  });

  test('checks if not exists', () {
    final aggregate = BookingAggregate();

    expect(() => aggregate.changePrice(12), throwsA(isA<DomainException>()));
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
    registry.on<PriceChanged>(
      (previousState, event) => previousState.onPriceChanged(event),
    );
  }

  book(int price) {
    ensureDoesntExist();
    apply(Booked(bookingId: 'anId', price: price));
  }

  changePrice(int newPrice) {
    ensureExists();
    apply(PriceChanged(newPrice: newPrice));
  }
}

@immutable
abstract class BookingEvent extends Equatable {}

class Booked extends BookingEvent {
  final String bookingId;
  final int price;

  Booked({required this.bookingId, required this.price});

  @override
  List<Object> get props => [bookingId, price];
}

class PriceChanged extends BookingEvent {
  final int newPrice;

  PriceChanged({required this.newPrice});

  @override
  List<Object?> get props => [newPrice];
}

class BookingId extends Equatable {
  final String id;

  BookingId(this.id);

  @override
  String toString() => id;

  @override
  List<Object> get props => [id];
}

class BookingState extends Equatable implements StateWithId<BookingId> {
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

  BookingState onPriceChanged(PriceChanged event) =>
      copyWith(price: event.newPrice);

  @override
  List<Object?> get props => [id, price];
}

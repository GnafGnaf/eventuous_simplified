import 'package:equatable/equatable.dart';
import 'package:eventuous_simplified/src/aggregate/aggregate.dart';
import 'package:eventuous_simplified/src/aggregate/stateful_aggregate.dart';
import 'package:eventuous_simplified/src/aggregate/typed_id.dart';
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

class BookingAggregate extends StatefulAggregate<BookingState>
    with TypedId<BookingState, BookingId> {
  book(int price) {
    ensureDoesntExist();
    apply(Booked(bookingId: 'anId', price: price));
  }

  changePrice(int newPrice) {
    ensureExists();
    apply(PriceChanged(newPrice: newPrice));
  }

  @override
  BookingState createInitialState() => BookingState.initial();

  @override
  void stateChanges(On<BookingState> on) => BookingState.changes(on);
}

@immutable
abstract class BookingEvent with EquatableMixin {}

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

class BookingState extends Equatable with TypedIdState<BookingId> {
  final int price;
  @override
  final BookingId? id;

  BookingState({required this.id, required this.price});

  factory BookingState.initial() => BookingState(id: null, price: 0);

  BookingState copyWith({BookingId? id, int? price}) {
    return BookingState(id: id ?? this.id, price: price ?? this.price);
  }

  static BookingState onBooked(
    Booked event,
    BookingState previousState,
  ) {
    return previousState.copyWith(
      id: BookingId(event.bookingId),
      price: event.price,
    );
  }

  static BookingState onPriceChanged(
    PriceChanged event,
    BookingState previousState,
  ) {
    return previousState.copyWith(price: event.newPrice);
  }

  @override
  List<Object?> get props => [id, price];

  static changes(On<BookingState> on) {
    on<Booked>(onBooked);
    on<PriceChanged>(onPriceChanged);
  }
}

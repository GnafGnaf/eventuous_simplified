// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booked _$BookedFromJson(Map<String, dynamic> json) => Booked(
      bookingId: json['bookingId'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$BookedToJson(Booked instance) => <String, dynamic>{
      'bookingId': instance.bookingId,
      'price': instance.price,
    };

Imported _$ImportedFromJson(Map<String, dynamic> json) => Imported(
      bookingId: json['bookingId'] as String,
    );

Map<String, dynamic> _$ImportedToJson(Imported instance) => <String, dynamic>{
      'bookingId': instance.bookingId,
    };

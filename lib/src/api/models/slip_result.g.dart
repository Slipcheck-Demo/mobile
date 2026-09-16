// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slip_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlipResult _$SlipResultFromJson(Map<String, dynamic> json) => SlipResult(
  bookingCode: json['bookingCode'] as String,
  selections: (json['selections'] as List<dynamic>)
      .map((e) => SlipSelection.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalOdds: (json['totalOdds'] as num).toDouble(),
);

Map<String, dynamic> _$SlipResultToJson(SlipResult instance) =>
    <String, dynamic>{
      'bookingCode': instance.bookingCode,
      'selections': instance.selections,
      'totalOdds': instance.totalOdds,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slip_selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlipSelection _$SlipSelectionFromJson(Map<String, dynamic> json) =>
    SlipSelection(
      outcomeId: json['outcomeId'] as String,
      marketId: json['marketId'] as String,
      marketName: json['marketName'] as String,
      outcomeName: json['outcomeName'] as String,
      eventId: (json['eventId'] as num).toInt(),
      eventName: json['eventName'] as String,
      eventEpoch: (json['eventEpoch'] as num).toInt(),
      priceDecimal: (json['priceDecimal'] as num).toDouble(),
      isBettable: json['isBettable'] as bool,
    );

Map<String, dynamic> _$SlipSelectionToJson(SlipSelection instance) =>
    <String, dynamic>{
      'outcomeId': instance.outcomeId,
      'marketId': instance.marketId,
      'marketName': instance.marketName,
      'outcomeName': instance.outcomeName,
      'eventId': instance.eventId,
      'eventName': instance.eventName,
      'eventEpoch': instance.eventEpoch,
      'priceDecimal': instance.priceDecimal,
      'isBettable': instance.isBettable,
    };

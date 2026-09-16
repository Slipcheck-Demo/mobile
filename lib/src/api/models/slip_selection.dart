import 'package:json_annotation/json_annotation.dart';

part 'slip_selection.g.dart';

/// Mirrors the backend's `RawSelection` shape exactly — see
/// stellar-test-task/backend/src/betway/types.ts (`DecodeSelection`, normalized) and
/// src/routes/resolve.ts's response mapping. Do not add fields the backend doesn't send.
@JsonSerializable()
class SlipSelection {
  const SlipSelection({
    required this.outcomeId,
    required this.marketId,
    required this.marketName,
    required this.outcomeName,
    required this.eventId,
    required this.eventName,
    required this.eventEpoch,
    required this.priceDecimal,
    required this.isBettable,
  });

  factory SlipSelection.fromJson(Map<String, dynamic> json) =>
      _$SlipSelectionFromJson(json);

  final String outcomeId;
  final String marketId;
  final String marketName;
  final String outcomeName;
  final int eventId;
  final String eventName;
  final int eventEpoch;
  final double priceDecimal;
  final bool isBettable;

  Map<String, dynamic> toJson() => _$SlipSelectionToJson(this);
}

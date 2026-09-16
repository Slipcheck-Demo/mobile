import 'package:json_annotation/json_annotation.dart';

import 'slip_selection.dart';

part 'slip_result.g.dart';

/// Mirrors the backend's `SlipResponse` shape — see
/// stellar-test-task/backend/src/routes/resolve.ts.
@JsonSerializable()
class SlipResult {
  const SlipResult({
    required this.bookingCode,
    required this.selections,
    required this.totalOdds,
  });

  factory SlipResult.fromJson(Map<String, dynamic> json) => _$SlipResultFromJson(json);

  final String bookingCode;
  final List<SlipSelection> selections;
  final double totalOdds;

  Map<String, dynamic> toJson() => _$SlipResultToJson(this);
}

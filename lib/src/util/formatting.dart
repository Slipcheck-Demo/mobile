import 'package:intl/intl.dart';

String formatOdds(double value) => value.toStringAsFixed(2);

final _kickoffFormat = DateFormat('d MMM, HH:mm');

String formatKickoff(int epochSeconds) {
  final date = DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000, isUtc: true).toLocal();
  return _kickoffFormat.format(date);
}

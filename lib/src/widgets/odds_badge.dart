import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../util/formatting.dart';

enum OddsBadgeSize { large, compact }

class OddsBadge extends StatelessWidget {
  const OddsBadge({super.key, required this.value, this.size = OddsBadgeSize.large});

  final double value;
  final OddsBadgeSize size;

  @override
  Widget build(BuildContext context) {
    final style = size == OddsBadgeSize.large
        ? AppTextStyles.oddsTotal
        : AppTextStyles.oddsTotalCompact;
    return Text(formatOdds(value), style: style);
  }
}

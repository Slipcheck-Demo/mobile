import 'package:flutter/material.dart';

import '../api/models/slip_selection.dart';
import '../theme/app_theme.dart';
import 'odds_badge.dart';
import 'selection_tile.dart';

// No `title`/`showTotal` params — mobile is Decode-only (see docs/plan.md §6), so unlike
// the web SlipCard this never needs the Convert "Kept"/"Removed" title-bar variant.
class SlipCard extends StatelessWidget {
  const SlipCard({
    super.key,
    required this.bookingCode,
    required this.selections,
    this.totalOdds,
  });

  final String bookingCode;
  final List<SlipSelection> selections;
  final double? totalOdds;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _LabeledValue(
                    label: 'BOOKING CODE',
                    child: Text(bookingCode, style: AppTextStyles.bookingCode),
                  ),
                ),
                if (totalOdds != null)
                  _LabeledValue(
                    alignEnd: true,
                    label: 'TOTAL ODDS',
                    child: OddsBadge(value: totalOdds!),
                  ),
              ],
            ),
          ),
          for (final selection in selections)
            SelectionTile(key: ValueKey(selection.outcomeId), selection: selection),
        ],
      ),
    );
  }
}

// The "uppercase label above a value" block is used for both the booking code and the
// total-odds figure — kept private to this file since it's only needed here.
class _LabeledValue extends StatelessWidget {
  const _LabeledValue({required this.label, required this.child, this.alignEnd = false});

  final String label;
  final Widget child;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.fieldLabel),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}

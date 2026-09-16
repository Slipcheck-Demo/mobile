import 'package:flutter/material.dart';

import '../api/models/slip_selection.dart';
import '../theme/app_theme.dart';
import 'odds_badge.dart';
import 'selection_tile.dart';

class SlipCard extends StatelessWidget {
  const SlipCard({
    super.key,
    required this.bookingCode,
    required this.selections,
    this.totalOdds,
    this.showTotal = true,
    this.title,
  });

  final String bookingCode;
  final List<SlipSelection> selections;
  final double? totalOdds;
  final bool showTotal;
  final String? title;

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
          if (title != null) _TitleBar(title: title!, count: selections.length),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('BOOKING CODE', style: AppTextStyles.fieldLabel),
                      const SizedBox(height: 4),
                      Text(bookingCode, style: AppTextStyles.bookingCode),
                    ],
                  ),
                ),
                if (showTotal && totalOdds != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('TOTAL ODDS', style: AppTextStyles.fieldLabel),
                      const SizedBox(height: 4),
                      OddsBadge(value: totalOdds!),
                    ],
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

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            '$count legs',
            style: AppTextStyles.marketName,
          ),
        ],
      ),
    );
  }
}

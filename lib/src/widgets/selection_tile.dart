import 'package:flutter/material.dart';

import '../api/models/slip_selection.dart';
import '../theme/app_theme.dart';
import '../util/formatting.dart';
import 'status_pill.dart';

class SelectionTile extends StatelessWidget {
  const SelectionTile({super.key, required this.selection});

  final SlipSelection selection;

  @override
  Widget build(BuildContext context) {
    final isDeadLeg = !selection.isBettable;

    return Opacity(
      opacity: isDeadLeg ? 0.55 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.borderSubtle)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Flexible(
                        child: Text(
                          selection.outcomeName,
                          style: AppTextStyles.outcomeName,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(selection.marketName, style: AppTextStyles.marketName),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${selection.eventName} · ${formatKickoff(selection.eventEpoch)}',
                    style: AppTextStyles.eventLine,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            StatusPill(isDeadLeg: isDeadLeg),
            const SizedBox(width: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 44),
              child: Text(
                formatOdds(selection.priceDecimal),
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.oddsFigure,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

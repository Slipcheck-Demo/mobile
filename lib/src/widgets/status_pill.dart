import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.isDeadLeg});

  final bool isDeadLeg;

  @override
  Widget build(BuildContext context) {
    final color = isDeadLeg ? AppColors.danger : AppColors.success;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        isDeadLeg ? 'Removed' : 'Active',
        style: AppTextStyles.statusPill.copyWith(color: color),
      ),
    );
  }
}

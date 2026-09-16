import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CodeInputForm extends StatelessWidget {
  const CodeInputForm({
    super.key,
    required this.controller,
    required this.onSubmit,
    required this.submitLabel,
    this.placeholder,
    this.hasError = false,
    this.enabled = true,
  });

  final TextEditingController controller;
  final VoidCallback onSubmit;
  final String submitLabel;
  final String? placeholder;
  final bool hasError;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            onSubmitted: (_) => onSubmit(),
            textInputAction: TextInputAction.done,
            style: AppTextStyles.bookingCode.copyWith(fontSize: 15),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: AppTextStyles.bookingCode.copyWith(
                fontSize: 15,
                color: AppColors.textTertiary,
              ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.md),
                borderSide: BorderSide(color: hasError ? AppColors.danger : AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.md),
                borderSide: BorderSide(color: hasError ? AppColors.danger : AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.md),
                borderSide: BorderSide(color: hasError ? AppColors.danger : AppColors.accent),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 48,
          child: FilledButton(
            onPressed: enabled ? onSubmit : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.onAccent,
              disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.5),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
            ),
            child: Text(submitLabel, style: AppTextStyles.button),
          ),
        ),
      ],
    );
  }
}

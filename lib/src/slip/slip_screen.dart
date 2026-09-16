import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/backend_client.dart';
import '../theme/app_theme.dart';
import '../widgets/code_input_form.dart';
import '../widgets/error_banner.dart';
import '../widgets/odds_badge.dart';
import '../widgets/slip_card.dart';
import '../widgets/slip_card_skeleton.dart';
import 'slip_provider.dart';

class SlipScreen extends ConsumerStatefulWidget {
  const SlipScreen({super.key});

  @override
  ConsumerState<SlipScreen> createState() => _SlipScreenState();
}

class _SlipScreenState extends ConsumerState<SlipScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final code = _controller.text.trim();
    if (code.isEmpty) return;
    ref.read(slipProvider.notifier).decode(code);
  }

  // Mirrors the web client's copy (docs/design-tokens.md "States" — Error), which already
  // covers both an invalid/expired code and a decoded-but-empty slip: the backend can't
  // tell those apart either (docs/betway-api.md §2 Расхождение №2), so neither can we.
  String _errorMessage(Object error) {
    if (error is BackendException && error.code == 'invalid_code') {
      return "We couldn't find a usable slip for that code. It may be wrong, expired, "
          'or have no selections left on it — double-check it and try again.';
    }
    return 'Something went wrong talking to Betway. Please try again in a moment.';
  }

  @override
  Widget build(BuildContext context) {
    final slipState = ref.watch(slipProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Slipcheck', style: AppTextStyles.wordmark),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_horiz, color: AppColors.textSecondary),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Decode a code', style: AppTextStyles.screenTitle.copyWith(fontSize: 20)),
                const SizedBox(height: 4),
                Text(
                  "See every selection, its odds, and whether it's still live.",
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 16),
                CodeInputForm(
                  controller: _controller,
                  onSubmit: _handleSubmit,
                  submitLabel: 'Go',
                  hasError: slipState.hasError,
                  enabled: !slipState.isLoading,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: slipState.when(
                data: (result) => result == null
                    ? const SizedBox.shrink()
                    : SlipCard(
                        bookingCode: result.bookingCode,
                        selections: result.selections,
                        totalOdds: result.totalOdds,
                      ),
                loading: () => const SlipCardSkeleton(),
                error: (error, _) => ErrorBanner(message: _errorMessage(error)),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: slipState.value != null
          ? _TotalOddsBar(totalOdds: slipState.value!.totalOdds)
          : null,
    );
  }
}

class _TotalOddsBar extends StatelessWidget {
  const _TotalOddsBar({required this.totalOdds});

  final double totalOdds;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total odds', style: AppTextStyles.body.copyWith(fontSize: 12)),
            OddsBadge(value: totalOdds, size: OddsBadgeSize.compact),
          ],
        ),
      ),
    );
  }
}

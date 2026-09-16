import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Matches the web client's `.skeleton` shimmer (docs/design-tokens.md "States" — Loading):
/// a moving gradient sweep, same three-stop tones, ~1.6s loop.
class SlipCardSkeleton extends StatefulWidget {
  const SlipCardSkeleton({super.key});

  @override
  State<SlipCardSkeleton> createState() => _SlipCardSkeletonState();
}

class _SlipCardSkeletonState extends State<SlipCardSkeleton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _bar(height: 20, widthFactor: 0.4),
          const SizedBox(height: 14),
          _bar(height: 52),
          const SizedBox(height: 14),
          _bar(height: 52),
          const SizedBox(height: 14),
          _bar(height: 52),
        ],
      ),
    );
  }

  Widget _bar({required double height, double widthFactor = 1}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return ShaderMask(
              shaderCallback: (rect) {
                final t = _controller.value;
                return LinearGradient(
                  begin: Alignment(-1 - t * 2, 0),
                  end: Alignment(1 - t * 2, 0),
                  colors: const [
                    AppColors.surfaceRaised,
                    Color(0xFF1E2431),
                    AppColors.surfaceRaised,
                  ],
                  stops: const [0.25, 0.5, 0.75],
                ).createShader(rect);
              },
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

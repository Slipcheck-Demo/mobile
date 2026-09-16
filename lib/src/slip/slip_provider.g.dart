// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slip_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `class Slip extends _$Slip` generates `slipProvider` (no `Notifier` suffix) — see
/// mobile/.claude/skills/flutter-riverpod-slip/SKILL.md rule 3.

@ProviderFor(Slip)
final slipProvider = SlipProvider._();

/// `class Slip extends _$Slip` generates `slipProvider` (no `Notifier` suffix) — see
/// mobile/.claude/skills/flutter-riverpod-slip/SKILL.md rule 3.
final class SlipProvider extends $AsyncNotifierProvider<Slip, SlipResult?> {
  /// `class Slip extends _$Slip` generates `slipProvider` (no `Notifier` suffix) — see
  /// mobile/.claude/skills/flutter-riverpod-slip/SKILL.md rule 3.
  SlipProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'slipProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$slipHash();

  @$internal
  @override
  Slip create() => Slip();
}

String _$slipHash() => r'7169495b65321a1a255fba07b0e7f2c645d6066b';

/// `class Slip extends _$Slip` generates `slipProvider` (no `Notifier` suffix) — see
/// mobile/.claude/skills/flutter-riverpod-slip/SKILL.md rule 3.

abstract class _$Slip extends $AsyncNotifier<SlipResult?> {
  FutureOr<SlipResult?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SlipResult?>, SlipResult?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SlipResult?>, SlipResult?>,
              AsyncValue<SlipResult?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

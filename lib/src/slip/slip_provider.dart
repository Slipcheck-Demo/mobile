import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/backend_client.dart';
import '../api/models/slip_result.dart';

part 'slip_provider.g.dart';

/// `class Slip extends _$Slip` generates `slipProvider` (no `Notifier` suffix) — see
/// mobile/.claude/skills/flutter-riverpod-slip/SKILL.md rule 3.
@riverpod
class Slip extends _$Slip {
  @override
  FutureOr<SlipResult?> build() => null;

  Future<void> decode(String bookingCode) async {
    state = const AsyncLoading();
    final client = ref.read(backendClientProvider);
    state = await AsyncValue.guard(() => client.resolveCode(bookingCode));
  }
}

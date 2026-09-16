---
name: flutter-riverpod-slip
description: Use when writing or reviewing Flutter/Dart code in mobile/ for the Betway booking-code slip screen — Riverpod v3 provider correctness, minimal one-screen structure (no multi-feature clean-architecture scaffolding), and widget-quality checks. Triggers on "flutter screen", "riverpod provider", "add a notifier", "review this widget", "audit presentation".
---

> **Adapted from** [`iamantoniodinuzzo/claude-flutter`](https://github.com/iamantoniodinuzzo/claude-flutter)
> (MIT license; skills `scaffold-feature`, `audit-presentation-layer`, agent `riverpod-reviewer`).
> The original targets a large feature-first app with multiple features, go_router, Robot
> Testing, etc. Here it is trimmed down to a single screen (the slip view) — see "What was
> dropped from the original" at the bottom.

# Flutter + Riverpod for the slip screen

This project has **one screen**: the user enters a booking code (or lands here after a
Decode/Convert on the backend) and sees a slip card (matches / markets / selections /
odds). There is no cross-feature navigation and no local persistence — all data comes from
our Node backend (`GET/POST /api/booking-codes/...`), which itself talks to Betway.

## Structure (minimal, not feature-first)

```
mobile/lib/
├── main.dart                       ProviderScope + MaterialApp
├── src/
│   ├── api/
│   │   ├── backend_client.dart     thin http client to our backend (dio or http)
│   │   └── models/                 SlipSelection, SlipResult — dto, fromJson
│   ├── slip/
│   │   ├── slip_provider.dart      AsyncNotifier<SlipState>, calls backend_client
│   │   └── slip_screen.dart        ConsumerWidget: code input + slip card
│   └── widgets/
│       └── selection_tile.dart     one slip row (match, market, odds)
```

Do not create separate `domain/`, `data/repositories/`, `application/notifiers/` layers —
for a single screen that indirection is pure overhead. `slip_provider.dart` calls
`backend_client.dart` directly.

## Riverpod v3 — correctness rules (check on every change)

Run through these on every change to `slip_provider.dart` / `slip_screen.dart`:

1. **`ref.watch()` only inside `build()`.** In callbacks (`onPressed`, `onSubmitted`) use
   only `ref.read()`. Violating this breaks rebuilds.
2. **`.select()` when reading a single field.**
   `ref.watch(slipProvider.select((s) => s.selections))` instead of
   `ref.watch(slipProvider).selections`.
3. **v3 provider naming**: `class SlipNotifier extends AsyncNotifier<SlipState>` generates
   `slipProvider` (no `Notifier` suffix). Never reference `slipNotifierProvider`.
4. **`Ref`, not `FooRef`.** Function providers take `Ref ref`; all the `XxxRef` subclasses
   were removed in v3.
5. **`AsyncValue` — handle all three states.** Use `.when(data:, loading:, error:)`. Never
   read `.value!` without checking state — `.value` is nullable in v3.
6. **`keepAlive`** — not needed here (one screen, alive only while the widget is mounted).
7. If `@riverpod` annotations changed, remind the user to run
   `dart run build_runner build --build-filter="lib/src/slip/**"` (never combined with
   `--delete-conflicting-outputs`, to avoid touching generated files outside scope).

Report format for reviews:
```
[SEVERITY] file:line — rule
  Found:  <code>
  Fix:    <code>
```

## Widget quality (trimmed checklist)

From the original's full catalog, keeping only what applies to a single static screen
with no routing:

- **`const` wherever possible**: literal `SizedBox`, `EdgeInsets.*`, `Icon`, `Divider` —
  wrap in `const` when the whole subtree has no external dependencies.
- **Extract widgets, not build helpers**: not `Widget _buildRow(...)`, but
  `class SelectionTile extends StatelessWidget`.
- **`build()` no longer than ~80 lines** — if the slip card grows, extract list rows into
  `SelectionTile`.
- **No side effects inside `build()`**: `showDialog`, `ScaffoldMessenger.of(context).show...`
  — only in event handlers, never in the body of `build`.
- **`AsyncValue` → UI directly in `build()`**:
  `ref.watch(slipProvider).when(data: ..., loading: () => CircularProgressIndicator(), error: (e, _) => Text('...'))`.

## What was dropped from the original

Deliberately not carried over (unnecessary for a single-screen MVP, but worth revisiting
if the project grows beyond the take-home scope):
- `scaffold-feature`'s feature-first layers (`domain/`, `data/`, `application/`) — overkill
  without multiple features.
- `go_router` conventions — there is no navigation between screens.
- The Robot Testing pattern and widget-test infrastructure — beyond the "rough one-screen"
  scope from the assessment; can be added back as a separate step if time allows.
- Sentry / force-update / flavors setup — not required for this assessment.

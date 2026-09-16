# betway-booking-mobile

Flutter app for the Betway Nigeria booking-code product — one screen: Decode. Talks to
[`../backend`](../backend) via `dio`/`retrofit` — never calls Betway directly. No CORS
setup needed for this client (CORS is a browser-only concern; Dio on iOS/Android isn't
subject to it).

Design: [Claude Design canvas](https://claude.ai/artifact/X28GaTC2QPLeU9hVkUTuKD)
(`Mobile.dc.html` artboard), tokens in `../docs/design-tokens.md` — read that file before
changing any color/spacing/typography value here. System architecture and sequence
diagrams live in the `betway-booking-backend` repo's `docs/architecture.md`.

## Architecture

Minimal, single-screen structure (no `domain/`/`data/`/`application/` layers) — see
`.claude/skills/flutter-riverpod-slip/SKILL.md` for the full rationale and Riverpod v3
conventions this follows.

```
lib/
├── main.dart
└── src/
    ├── theme/         design tokens (colors, typography)
    ├── config/        env config (API_BASE_URL, read from .env)
    ├── api/           retrofit REST interface + dio client + json_serializable DTOs
    ├── slip/           Riverpod state (slipProvider) + the screen
    └── widgets/        SlipCard, SelectionTile, StatusPill, OddsBadge, ErrorBanner, ...
```

Generated code (`*.g.dart` from `build_runner`) is committed, not gitignored.

## Dev setup

Requires [`../backend`](../backend) running locally first (`npm run dev` — no database or
setup step needed, see that repo's README).

```
cp .env.example .env          # API_BASE_URL, defaults to http://localhost:3000
flutter pub get
dart run build_runner build   # regenerate *.g.dart after changing an @riverpod/@RestApi/@JsonSerializable class
flutter run
```

## Checks

```
flutter analyze
```

No automated widget tests (deferred per the skill's own scope — see its "What was dropped"
section); verified instead by running in a real iOS simulator against the live backend +
live Betway data.

## Android release build

```
cp .env.example .env          # point API_BASE_URL at the live backend before building
flutter build apk --release
```

Produces `build/app/outputs/flutter-apk/app-release.apk`, signed with the Flutter default
debug keystore (no dedicated release keystore was set up — acceptable for this take-home;
a real release would need its own signing key). Distributed via Firebase App Distribution.

## iOS distribution path

This repo was only built and verified for Android (Flutter's iOS toolchain needs a macOS
host with Xcode, which this delivery didn't run against a physical/TestFlight pipeline). To
ship an IPA instead, the *app code itself needs no changes* — it's the same Flutter/Dart
source, `dio`/`retrofit`/Riverpod work identically on both platforms. What changes is purely
platform tooling:

1. **Signing** — an Apple Developer Program account, a Distribution certificate, and a
   provisioning profile (App Store or Ad Hoc) in place of Android's debug keystore.
2. **Build** — `flutter build ipa` instead of `flutter build apk`, run from Xcode/macOS
   (there's no cross-compiling an IPA from Linux/Windows).
3. **Distribution** — either Firebase App Distribution's iOS track (same `firebase
   appdistribution:distribute`, pointed at the `.ipa`) or TestFlight; both need the app
   registered in App Store Connect first.
4. **Permissions** — `Info.plist` needs an `NSAppTransportSecurity` exception (or a real
   TLS cert on the backend's domain, which it already has via `docs/architecture.md`'s
   `sslip.io` cert) since Betway's/our own HTTPS setup should already satisfy ATS with no
   extra entries.

No Dart/Flutter code changes — this is entirely a packaging/signing/distribution-pipeline
difference, which is why it wasn't worth doing without a real Apple Developer account for a
take-home.

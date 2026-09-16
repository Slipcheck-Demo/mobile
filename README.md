# betway-booking-mobile

Flutter app for the Betway Nigeria booking-code product — one screen: Decode. Talks to
[`../backend`](../backend) — never calls Betway directly. No CORS setup needed for this
client (CORS is a browser-only concern; Dart's `http` client on iOS/Android isn't subject
to it).

Design: [Claude Design canvas](https://claude.ai/artifact/X28GaTC2QPLeU9hVkUTuKD)
(`Mobile.dc.html` artboard), tokens in `../docs/design-tokens.md` — read that file before
changing any color/spacing/typography value here.

## Architecture

Minimal, single-screen structure (no `domain/`/`data/`/`application/` layers) — see
`.claude/skills/flutter-riverpod-slip/SKILL.md` for the full rationale and Riverpod v3
conventions this follows.

```
lib/
├── main.dart
└── src/
    ├── theme/         design tokens (colors, typography)
    ├── api/           backend HTTP client + json_serializable DTOs
    ├── slip/           Riverpod state (slipProvider) + the screen
    └── widgets/        SlipCard, SelectionTile, StatusPill, OddsBadge, ErrorBanner, ...
```

Generated code (`*.g.dart` from `build_runner`) is committed, not gitignored.

## Dev setup

Requires [`../backend`](../backend) running locally first (`docker compose up -d && npx
prisma migrate dev && npm run dev`).

```
flutter pub get
dart run build_runner build   # regenerate *.g.dart after changing an @riverpod/@JsonSerializable class
flutter run --dart-define=API_BASE_URL=http://localhost:3000   # defaults to this URL if omitted
```

## Checks

```
flutter analyze
```

No automated widget tests (deferred per the skill's own scope — see its "What was dropped"
section); verified instead by running in a real iOS simulator against the live backend +
live Betway data.

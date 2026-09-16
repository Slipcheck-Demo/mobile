import 'package:flutter_dotenv/flutter_dotenv.dart';

const _defaultApiBaseUrl = 'http://localhost:3000';

/// Reads API_BASE_URL from the .env asset (see .env.example) — call after
/// `dotenv.load()` has run in main(). Falls back to localhost so a missing/incomplete
/// .env doesn't crash the app, just points it at the default local backend.
String dotenvBaseUrl() => dotenv.maybeGet('API_BASE_URL') ?? _defaultApiBaseUrl;

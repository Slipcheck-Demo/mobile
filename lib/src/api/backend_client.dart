import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'models/slip_result.dart';

part 'backend_client.g.dart';

/// Thin client to our own backend — never calls Betway directly (see
/// stellar-test-task/docs/betway-api.md §10 and the backend's own README for why).
/// Override at build/run time: --dart-define=API_BASE_URL=https://your-backend.example.com
const _defaultBaseUrl = 'http://localhost:3000';
const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: _defaultBaseUrl);

/// The backend's own error taxonomy (`{ "error": <code> }`) — see
/// stellar-test-task/backend/src/httpErrors.ts. Never a raw Betway error code/message.
class BackendException implements Exception {
  BackendException(this.code, this.statusCode);

  final String code;
  final int statusCode;

  @override
  String toString() => 'BackendException($code, status: $statusCode)';
}

class BackendClient {
  BackendClient({required this.baseUrl, http.Client? httpClient})
      : _http = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client _http;

  Future<SlipResult> resolveCode(String bookingCode) async {
    final response = await _http.post(
      Uri.parse('$baseUrl/api/booking-codes/resolve'),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({'bookingCode': bookingCode}),
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw BackendException(
        body['error'] as String? ?? 'upstream_error',
        response.statusCode,
      );
    }

    return SlipResult.fromJson(body);
  }
}

@riverpod
BackendClient backendClient(Ref ref) => BackendClient(baseUrl: apiBaseUrl);

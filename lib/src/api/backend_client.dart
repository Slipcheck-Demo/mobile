import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/env.dart';
import 'models/slip_result.dart';

part 'backend_client.g.dart';

/// The backend's own error taxonomy (`{ "error": <code> }`) — see
/// stellar-test-task/backend/src/httpErrors.ts. Never a raw Betway error code/message.
class BackendException implements Exception {
  BackendException(this.code, this.statusCode);

  final String code;
  final int statusCode;

  @override
  String toString() => 'BackendException($code, status: $statusCode)';
}

/// Thin, generated REST interface to our own backend — never calls Betway directly (see
/// stellar-test-task/docs/betway-api.md §10 and the backend's own README for why). Wrapped
/// by [BackendClient] below, which is what the rest of the app actually calls: retrofit
/// lets a non-2xx response's `{ "error": <code> }` body escape as a raw DioException, so a
/// wrapper is still needed to map that into our own [BackendException].
@RestApi()
abstract class BookingCodesApi {
  factory BookingCodesApi(Dio dio, {String baseUrl}) = _BookingCodesApi;

  @POST('/api/booking-codes/resolve')
  Future<SlipResult> resolveCode(@Body() Map<String, dynamic> body);
}

class BackendClient {
  BackendClient(Dio dio) : _api = BookingCodesApi(dio);

  final BookingCodesApi _api;

  Future<SlipResult> resolveCode(String bookingCode) async {
    try {
      return await _api.resolveCode({'bookingCode': bookingCode});
    } on DioException catch (e) {
      final data = e.response?.data;
      final code = data is Map ? data['error'] as String? : null;
      throw BackendException(code ?? 'upstream_error', e.response?.statusCode ?? 502);
    }
  }
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  // dotenv.load() must have already run in main() before this provider is first read.
  final baseUrl = dotenvBaseUrl();
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 12),
    ),
  );
  ref.onDispose(dio.close);
  return dio;
}

@Riverpod(keepAlive: true)
BackendClient backendClient(Ref ref) => BackendClient(ref.watch(dioProvider));

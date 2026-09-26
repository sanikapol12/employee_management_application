import 'package:flutter/foundation.dart';

/// Centralized logger for tracking activities, API requests/responses, and errors
class AppLogger {
  static void activity(String activityName, [Map<String, dynamic>? details]) {
    final timestamp = DateTime.now().toIso8601String().substring(11, 19);
    final detailStr = details != null && details.isNotEmpty ? ' | Details: $details' : '';
    debugPrint('[$timestamp] 🎯 [ACTIVITY] $activityName$detailStr');
  }

  static void apiRequest(String method, String url, [dynamic body]) {
    final timestamp = DateTime.now().toIso8601String().substring(11, 19);
    debugPrint('\n======================================================');
    debugPrint('[$timestamp] 🌐 [API REQUEST] $method $url');
    if (body != null) {
      debugPrint('   ↳ Payload: $body');
    }
  }

  static void apiResponse(String method, String url, int statusCode, dynamic body) {
    final timestamp = DateTime.now().toIso8601String().substring(11, 19);
    final isSuccess = statusCode >= 200 && statusCode < 300;
    final emoji = isSuccess ? '✅' : '⚠️';
    debugPrint('[$timestamp] $emoji [API RESPONSE] $method $url | Status: $statusCode');
    debugPrint('   ↳ Body: $body');
    debugPrint('======================================================\n');
  }

  static void error(String context, dynamic error, [StackTrace? stackTrace]) {
    final timestamp = DateTime.now().toIso8601String().substring(11, 19);
    debugPrint('\n******************************************************');
    debugPrint('[$timestamp] ❌ [ERROR] in $context: $error');
    if (stackTrace != null) {
      debugPrint('   ↳ StackTrace: $stackTrace');
    }
    debugPrint('******************************************************\n');
  }
}

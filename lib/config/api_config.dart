import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiConfig {
  static String? _workingBaseUrl;

  /// Candidate base URLs to connect to Spring Boot API (port 9000)
  static List<String> get candidateUrls {
    if (kIsWeb) {
      return const [
        'http://localhost:9000',
        'http://127.0.0.1:9000',
      ];
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const [
        'http://10.0.2.2:9000', // Android Emulator
        'http://localhost:9000', // adb reverse or local
        'http://192.168.100.35:9000', // Physical device over Wi-Fi
      ];
    }
    // Windows Desktop, macOS, Linux, iOS simulator
    return const [
      'http://localhost:9000',
      'http://127.0.0.1:9000',
      'http://192.168.100.35:9000',
    ];
  }

  /// Get the current or default base URL
  static String get baseUrl {
    if (_workingBaseUrl != null) return _workingBaseUrl!;
    if (kIsWeb) return 'http://localhost:9000';
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:9000';
    }
    return 'http://localhost:9000';
  }

  /// Perform a GET request with smart discovery across candidate base URLs
  static Future<http.Response> get(String path) async {
    final normalizedPath = path.startsWith('/') ? path : '/$path';

    // 1. If we already established a working URL, try it first
    if (_workingBaseUrl != null) {
      try {
        final res = await http
            .get(Uri.parse('$_workingBaseUrl$normalizedPath'))
            .timeout(const Duration(seconds: 4));
        if (res.statusCode >= 200 && res.statusCode < 400) {
          return res;
        }
      } catch (e) {
        debugPrint('Cached baseUrl $_workingBaseUrl failed: $e, rediscovering...');
        _workingBaseUrl = null;
      }
    }

    // 2. Discover working URL from candidate list
    Object? lastError;
    for (final base in candidateUrls) {
      try {
        final uri = Uri.parse('$base$normalizedPath');
        final res = await http.get(uri).timeout(const Duration(seconds: 3));
        if (res.statusCode >= 200 && res.statusCode < 400) {
          _workingBaseUrl = base;
          debugPrint('Connected to API via: $base');
          return res;
        }
      } catch (e) {
        lastError = e;
        debugPrint('Candidate URL $base failed: $e');
      }
    }

    throw Exception('Failed to connect to API on any candidate URL: $lastError');
  }
}

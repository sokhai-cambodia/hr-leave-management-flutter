import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Env._();

  static const String _defaultApiBaseUrl = 'http://10.0.2.2:8000/api/v1';

  // --dart-define always wins (e.g. CI builds); falls back to .env (local dev
  // convenience, see .env.example), then to the hardcoded default.
  static const String _dartDefineApiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
  );

  static String get apiBaseUrl {
    if (_dartDefineApiBaseUrl.isNotEmpty) return _dartDefineApiBaseUrl;
    return dotenv.env['API_BASE_URL'] ?? _defaultApiBaseUrl;
  }
}

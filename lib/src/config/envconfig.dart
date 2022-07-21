import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A collection of important environment configurations.
class EnvConfig {
  EnvConfig._();
  static Future<void> initialize() async {
    await instance._env.load();
  }

  static final _envConfig = EnvConfig._();

  static EnvConfig get instance => _envConfig;

  String get(String key, {String? fallback}) {
    return _env.get(key, fallback: fallback);
  }

  final DotEnv _env = DotEnv();
}

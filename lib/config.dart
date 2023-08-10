abstract class Config {
  static late String _environment;

  static Future<void> initialize(String environment) async {
    _environment = environment;
  }

  static String get environment => _environment;

  static String get appName => const String.fromEnvironment('appName');
}

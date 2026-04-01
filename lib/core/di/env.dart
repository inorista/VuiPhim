import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: './.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'API-KEY')
  static String apiKey = _Env.apiKey;
}

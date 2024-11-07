import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvKeys { movieDbKey, }

class EnvVariablesManager {

  /// Cargar archivo .env con las variables de entorno
  static loadEnvVariables() async => await dotenv.load(fileName: ".env");


  /// Obtener la informacion de una variable de entorno
  static getEnvVariable({required EnvKeys value}) {
    String key = _getKeyFromEnumValue(value) ?? '';
    return dotenv.env[key] ?? 'no-api-key';
  }


  /// Obtener [key] a partir del enum
  static String? _getKeyFromEnumValue(EnvKeys value){
    switch (value) {
      case EnvKeys.movieDbKey: return "THE_MOVIEDB_KEY";
    }
  }

}
import 'package:cinepedia/src/domain/entities/actor.dart';

/// Definir funciones que se ocuparan para las peticiones
abstract class ActorsRepository {

  /// Definir como debe de lucir la peticion [getActorsByMovie]
  Future<List<Actor>> getActorsByMovie(String movieId);

}
import 'package:cinepedia/src/domain/entities/movie.dart';

/// Definir funciones que se ocuparan para las peticiones
abstract class MovieRepository {

  /// Definir como debe de lucir la peticion [getNowPlaying]
  Future<Movie> getMovieById({ int page = 1 });
}
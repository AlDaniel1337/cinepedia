import 'package:cinepedia/src/domain/entities/movie.dart';

/// Definir funciones que se ocuparan para las peticiones
abstract class MovieDatasource {

  /// Definir como debe de lucir la peticion [getMovieById]
  Future<Movie> getMovieById(String id);

}
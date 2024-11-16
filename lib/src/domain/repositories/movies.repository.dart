import 'package:cinepedia/src/domain/entities/movie.dart';

/// Definir funciones que se ocuparan para las peticiones
abstract class MoviesRepository {

  /// Definir como debe de lucir la peticion [getNowPlaying]
  Future<List<Movie>> getNowPlaying({ int page = 1 });

  /// Definir como debe de lucir la peticion [getPopular]
  Future<List<Movie>> getPopular({ int page = 1 });
  
  /// Definir como debe de lucir la peticion [getUpcoming]
  Future<List<Movie>> getUpcoming({ int page = 1 });
  
  /// Definir como debe de lucir la peticion [searchMovies]
  Future<List<Movie>> searchMovies( String query );

  //& Similares
  /// Definir como debe de lucir la peticion [similarMovies]
  Future<List<Movie>> similarMovies(String movieId);

  //& Reocmendadas
  /// Definir como debe de lucir la peticion [recommendedMovies]
  Future<List<Movie>> recommendedMovies(String movieId);
}
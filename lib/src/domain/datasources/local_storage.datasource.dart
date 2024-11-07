import 'package:cinepedia/src/domain/entities/movie.dart';

/// Definir funciones que se ocuparan para las peticiones de la base de datos local
abstract class LocalStorageDatasource {

  /// Definir como debe de lucir la peticion [toggleFavorite]
  Future<void> toggleFavorite( Movie movie );

  /// Definir como debe de lucir la peticion [isMovieFavorite]
  Future<bool> isMovieFavorite( int movieId );

  /// Definir como debe de lucir la peticion [loadMovies]
  Future< List<Movie> > loadMovies({ int limit =10, offset = 0 });

}
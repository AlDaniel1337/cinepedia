//===========================================================
//* MANEJAR PETICIONES PARA OBTENER PELICULAS SIMILARES
//  En base al id de la pelicula buscada
//~ Almacena resultado en cache (mapa)
//===========================================================*/

import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//SECTION ========== Providers ==========

/// Peliculas recomendadas 
final similarMoviesProvider = StateNotifierProvider<MovieMapNotifier, Map< String, List<Movie> >>( (ref) {

  //* Obtener funcion principal para acceder a los metodos del [RepositoryImpl]
  final movieRepository = ref.watch( movieRepositoryProvider );

  return MovieMapNotifier(
    getMovies: movieRepository.similarMovies
  );

});

//! SECTION ========== Providers ==========



//& ========== Estado Principal ==========
class MovieMapNotifier extends StateNotifier <Map< String, List<Movie> >> {

  MovieCallback getMovies;

  MovieMapNotifier({
    required this.getMovies
  }):super({});

  /// Cargar peliculas recomendadas
  Future<void> loadSimilarMovies(String movieId) async {

    //# Revisar si la pelicula esta almacenada en cache
    if( state[movieId] != null ) return;

    // Agregar más peliculas
    final movies = await getMovies(movieId);

    state = {
      ...state,
      movieId: movies
    };
  }

}



//SECTION ========== Casos de uso ==========

/// Obtener listado de peliculas recomendadas
typedef MovieCallback = Future<List<Movie>> Function(String movieId);

//!SECTION ========== Casos de uso ==========
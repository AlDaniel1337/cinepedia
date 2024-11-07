//===========================================================
//* MANEJAR PETICIONES PARA OBTENER LOS DETALLES
//  Tambein almacena los resultados en cache (en un mapa)
//===========================================================*/

import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//^================================
//SECTION - Providers

/// Detalles de la pelicula
final moveInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>( (ref) {

  //* Obtener funcion principal para acceder a los metodos del [RepositoryImpl]
  final movieRepository = ref.watch( movieRepositoryProvider );

  return MovieMapNotifier(
    getMovie: movieRepository.getMovieById
  );
});

//! SECTION END - Providers
//!================================

/// Estado Principal 
class MovieMapNotifier extends StateNotifier <Map< String, Movie >> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie
  }):super({});

  /// Obtener la informacion de la pelicula
  Future<void> loadMovie(String movieId) async {

    //# Revisar si la pelicula esta almacenada en cache
    if( state[movieId] != null ) return;

    final movie = await getMovie( movieId );

    state = {
      ... state,
      movieId: movie
    };
  }

  

}


//^================================
//SECTION Casos de uso

/// Obtener pelicula
typedef GetMovieCallback = Future<Movie> Function(String movieId);

//!SECTION FIN casos de uso
//!================================
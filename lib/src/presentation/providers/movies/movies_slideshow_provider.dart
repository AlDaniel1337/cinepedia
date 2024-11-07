import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/providers/movies/movies_providers.dart';

/// Recortar listado de peliculas a un numero especificado [6]
final  moviesSlideshowProvider = Provider<List<Movie>>( (ref){

  //* Obtener peliculas que se estan reproduciendo
  final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );

  if( nowPlayingMovies.isEmpty ) return [];

  return nowPlayingMovies.sublist(0,6);

});
//===========================================================
//* MANEJAR PETICIONES PARA OBTENER LOS TRAILER O VIDEOS
//  Tambein almacena los resultados en cache (en un mapa)
//===========================================================*/

import 'package:cinepedia/src/domain/entities/videos.dart';
import 'package:cinepedia/src/presentation/providers/videos/movie_videos_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//^================================
//SECTION - Providers

/// Detalles de la pelicula
final videosByMovieIdProvider = StateNotifierProvider<VideosByMovieNotifier, Map< String, List<Videos> >>( (ref) {

  //* Obtener funcion principal para acceder a los metodos del [RepositoryImpl]
  final videosRepository = ref.watch(  movieVideosRepositoryProvider );

  return VideosByMovieNotifier(
    getVideos: videosRepository.getVideosByMovie
  );
});

//! SECTION END - Providers
//!================================



/// Estado Principal 
class VideosByMovieNotifier extends StateNotifier <Map< String, List<Videos> >> {

  final GetMoviesCallback getVideos;

  VideosByMovieNotifier({
    required this.getVideos
  }):super({});

  /// Obtener la informacion de los actores
  Future<void> loadMovieVideos(String movieId) async {

    //# Revisar si la pelicula esta almacenada en cache
    if( state[movieId] != null ) return;

    final List<Videos> videos = await getVideos( movieId );

    state = {
      ...state,
      movieId: videos
    };
  }

  

}


//SECTION 
//& =============== Casos de uso =============== &\\

/// Obtener actores de la pelicula
typedef GetMoviesCallback = Future< List<Videos> > Function(String movieId);
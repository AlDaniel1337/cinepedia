import 'dart:math';

import 'package:cinepedia/src/config/plugins/video_player.dart';
import 'package:cinepedia/src/presentation/providers/videos/movie_videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Contenedor con el video / trailer
class MovieVideo extends ConsumerWidget {

  final int movieId;
   
  const MovieVideo({
    super.key, 
    required this.movieId
  });
  
  @override
  Widget build(BuildContext context, ref) {

    //* Obtener videos
    final videos = ref.watch( videosByMovieIdProvider );

    //+ Indicar carga de videos
    if( videos[movieId.toString()] == null ){
      return const Center(child: CircularProgressIndicator());
    }

    final movieVideos = videos[movieId.toString()];

    if(movieVideos != null && movieVideos.isEmpty) return const Center(child: Text("Sin videos", style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold )));

    //* Seleccionar video de forma aleatoria
    var rng = Random();
    var selectedVideo = rng.nextInt(movieVideos!.length);

    return VideoPlayerPlugin(
      youtubeId: movieVideos[selectedVideo].key,
      name:      movieVideos[selectedVideo].name,
    );
  }
}
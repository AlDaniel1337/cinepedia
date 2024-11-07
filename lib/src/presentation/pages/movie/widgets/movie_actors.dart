import 'package:cinepedia/src/presentation/pages/movie/widgets/movie_actor.dart';
import 'package:cinepedia/src/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Contenedor con el listado de actores
class MovieActors extends ConsumerWidget {

  final int movieId;
   
  const MovieActors({
    super.key, 
    required this.movieId
  });
  
  @override
  Widget build(BuildContext context, ref) {

    //* Obtener actores
    final actors = ref.watch( actorsByMovieProvider );

    //+ Indicar carga de actores
    if( actors[movieId.toString()] == null ){
      return const Center(child: CircularProgressIndicator());
    }

    final movieActors = actors[movieId.toString()];

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieActors!.length,
        itemBuilder:(context, index) {
          final actor = movieActors[index];   
          return MovieActor(actor: actor);       
        },
      ),
    );
  }
}
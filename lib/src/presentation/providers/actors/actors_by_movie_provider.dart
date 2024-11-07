//===========================================================
//* MANEJAR PETICIONES PARA OBTENER LOS ACTORES
//  Tambein almacena los resultados en cache (en un mapa)
//===========================================================*/

import 'package:cinepedia/src/domain/entities/actor.dart';
import 'package:cinepedia/src/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//^================================
//SECTION - Providers

/// Detalles de la pelicula
final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map< String, List<Actor> >>( (ref) {

  //* Obtener funcion principal para acceder a los metodos del [RepositoryImpl]
  final actorsRepository = ref.watch( actorsRepositoryProvider );

  return ActorsByMovieNotifier(
    getActors: actorsRepository.getActorsByMovie
  );
});

//! SECTION END - Providers
//!================================



/// Estado Principal 
class ActorsByMovieNotifier extends StateNotifier <Map< String, List<Actor> >> {

  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors
  }):super({});

  /// Obtener la informacion de los actores
  Future<void> loadMovieActors(String movieId) async {

    //# Revisar si la pelicula esta almacenada en cache
    if( state[movieId] != null ) return;

    final actors = await getActors( movieId );

    state = {
      ... state,
      movieId: actors
    };
  }

  

}



//^================================
//SECTION Casos de uso

/// Obtener actores de la pelicula
typedef GetActorsCallback = Future< List<Actor> > Function(String movieId);

//!SECTION FIN casos de uso
//!================================
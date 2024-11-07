import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/domain/repositories/local_storage.repository.dart';
import 'package:cinepedia/src/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Proveedor para las peliculas favoritas
final favoritesMoviesProvider = StateNotifierProvider < StorageMovieNotifier, Map<int, Movie> > ((ref) {
  // Obtener provider del local storage
  final localStorageRepository = ref.watch( localStorageRepositoryProvider );

  return StorageMovieNotifier(localStorageRepository: localStorageRepository);
});


/// Estado principal
class StorageMovieNotifier extends StateNotifier< Map<int, Movie> > {

  int page = 0;
  bool isLoading = false;
  
  final LocalStorageRepository localStorageRepository;
  
  StorageMovieNotifier({
    required this.localStorageRepository
  }): super({});


  /// Cargar siguiente pagina de peliculas favoritas
  Future< List<Movie> > loadNextPage() async {

    // Cargar peliculas
    final movies = await localStorageRepository.loadMovies( offset: page * 10, limit: 20 );
    page += 1;

    // Generar mapa temporal para agregar nuevas peliculas
    final tempMoviesMap = <int, Movie> {};
    for( final movie in movies ){
      tempMoviesMap[movie.id] = movie;
    }

    // Modificar state
    state = { ...state, ...tempMoviesMap};

    return movies;
  }

  /// Agregar o quitar una pelicula a favoritos
  Future<void> toggleFavorite( Movie movie) async {

    await localStorageRepository.toggleFavorite( movie );

    final bool isMovieInFavorites = state[movie.id] != null;

    if( isMovieInFavorites) {
    //+ Remover del estado si la pelicula esta en favoritos pero se cambio su estado de 'favorita'
      state.remove( movie.id ); // Remover
      state = { ...state }; //? Notificar nuevo estado
    }
    else{
    //- Agregar la pelicula si se agrego una nueva a favoritos
      state = { ...state, movie.id: movie };
    }

  }
  
}
import 'package:cinepedia/src/domain/entities/movie.dart';
import 'package:cinepedia/src/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//SECTION - Providers
/// En cartelera
final nowPlayingMoviesProvider = StateNotifierProvider< MoviesNotifier, List<Movie> >( (ref) {

  //* Obtener funcion principal para acceder a los metodos del [RepositoryImpl]
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


/// Populares
final popularMoviesProvider = StateNotifierProvider< MoviesNotifier, List<Movie> >( (ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getPopular;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

/// Proximamente
final upcomingMoviesProvider = StateNotifierProvider< MoviesNotifier, List<Movie> >( (ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getUpcoming;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});




/// Estado Principal para los providers
class MoviesNotifier extends StateNotifier< List<Movie> > {
  // Pagina actual
  int currentPage = 0;
  // Funcion para actualizar el listado
  MovieCallback fetchMoreMovies;
  // Indicador de carga
  bool isLoading = false;
  // Fecha actual
  DateTime today = DateTime.now();

  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);

  /// Cargar mas peliculas
  Future< List<Movie> > loadNextPage() async {

    //+ Verificar si esta cargando
    if(isLoading) return [];
    isLoading = true;

    // Agregar mas peliculas
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies( page: currentPage );
    state = [...state, ...movies];

    isLoading = false;

    return movies;
  }

  /// Obtener fecha
  (String, int) loadDate(){
    List<String> days = ['Lunes', 'Martes', "Miercoles", 'Jueves', 'Viernes', 'Sabado', 'Domingo'];
    return (days[today.weekday-1], today.day);
  }

}

//SECTION Casos de uso

/// Obtener listado de peliculas
typedef MovieCallback = Future< List<Movie> > Function({ int page });

//!SECTION FIN casos de uso
//^ Fuente de datos


import 'package:cinepedia/src/config/plugins/env_variables.dart';
import 'package:cinepedia/src/config/plugins/http.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/infrastructure/infrastructure.dart';
import 'package:cinepedia/src/infrastructure/models/moviedb/movie_details.dart';

/// implementacion de la clases definidas en 
class MoviedbDatasource extends MoviesDatasource implements  MovieDatasource {

  /// Configuracion del plugin http para este datasource
  final HttpAdapter _httpAdapter = HttpAdapter(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': EnvVariablesManager.getEnvVariable(value: EnvKeys.movieDbKey),
      'language': 'es-MX',
    }
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return _getMovies(page: page, url: UrlList.nowPlaying);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return _getMovies(page: page, url: UrlList.popular);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return _getMovies(page: page, url: UrlList.upcoming);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return _getMovie(movieId: id);
  }

  @override
  Future<List<Movie>> searchMovies( String query ) async {

    String path = "/search/movie";
    
    //* Peticion http
    final response = await _httpAdapter.get(
      path: path,
      queryParameters: {
        'query': query
      }
    );

    //* Pasar respuesta a modelo de MovieDb
    final moviesResponse = MovieDbResponse.fromMap( response.data );

    //* Pasar modelo (MovieDb) a entidad local (usando el mapper)
    final List<Movie> movies = moviesResponse.results
    .where( (moviedb) => moviedb.posterPath != 'no-poster') //? Filtro: si no tiene poster no se agrega
    .map( (moviedb) => MovieMapper.movieDBtoEntity(moviedb) ).toList();

    return movies;
  }

  @override
  Future<List<Movie>> recommendedMovies(String movieId) {
    return _getMovies(url: UrlList.recommended, movieId: movieId);
  }
  
  @override
  Future<List<Movie>> similarMovies(String movieId) {
    return _getMovies(url: UrlList.similar, movieId: movieId);
  }
  


  /// Obtener listado de peliculas
  Future<List<Movie>> _getMovies({int page = 1, required UrlList url, String movieId = ""}) async {

    String path = _getUrl(url: url, movieId: movieId);
    
    //* Peticion http
    final response = await _httpAdapter.get(path: path, 
    queryParameters: { 
      "page":page 
    });

    //* Pasar respuesta a modelo de MovieDb
    final moviesResponse = MovieDbResponse.fromMap( response.data );

    //* Pasar modelo (MovieDb) a entidad local (usando el mapper)
    final List<Movie> movies = moviesResponse.results
    .where( (moviedb) => moviedb.posterPath != 'no-poster') //? Filtro: si no tiene poster no se agrega
    .map( (moviedb) => MovieMapper.movieDBtoEntity(moviedb) ).toList();

    return movies;
  } 


  /// Obtener detalles de una pelicula
  Future<Movie> _getMovie({required String movieId}) async {

    String path = "/movie/$movieId";
    
    //* Peticion http
    final response = await _httpAdapter.get(path: path);

    //+ Respuesta vacia
    if( response.statusCode != 200 ) throw Exception("Movie with id $movieId not found");

    //* Pasar respuesta a modelo de MovieDb
    final movieDetails = MovieDetails.fromMap( response.data );

    //* Pasar modelo (MovieDb) a entidad local (usando el mapper)
    final Movie movie = MovieMapper.movieDetailsDBtoEntity( movieDetails );

    return movie;
  } 


  /// Obtener url en base a un enum
  String _getUrl({ required UrlList url, String movieId = ""}){
    
    if(movieId != "") movieId = '$movieId/';

    switch (url){
      case (UrlList.nowPlaying):  return '/movie/now_playing';
      case (UrlList.popular):     return '/movie/popular';
      case (UrlList.upcoming):    return '/movie/upcoming';
      case (UrlList.topRated):    return '/movie/top_rated';
      case (UrlList.recommended): return '/movie/${movieId}recommendations';
      case (UrlList.similar):     return '/movie/${movieId}similar';
    }
  }
 
}

enum UrlList {nowPlaying, popular, upcoming, topRated, recommended, similar}
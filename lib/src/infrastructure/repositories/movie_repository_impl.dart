import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/infrastructure/datasources/moviedb_datasource.dart';

class MovieRepositoryImpl extends MoviesRepository implements  MovieDatasource {

  final MoviedbDatasource datasource;

  MovieRepositoryImpl({
    required this.datasource
  });

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page:page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page:page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page:page);
  }
  
  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
  
  @override
  Future<List<Movie>> searchMovies( String query ) {
    return datasource.searchMovies(query);
  }
  
  @override
  Future<List<Movie>> recommendedMovies(String movieId) {
    return datasource.recommendedMovies(movieId);
  }
  
  @override
  Future<List<Movie>> similarMovies(String movieId) {
    return datasource.similarMovies(movieId);
  }

}
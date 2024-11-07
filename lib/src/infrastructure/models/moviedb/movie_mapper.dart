import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/infrastructure/infrastructure.dart';
import 'package:cinepedia/src/infrastructure/models/moviedb/movie_details.dart';

/// Pasar informacion de la respuesta a la entidad local
class MovieMapper {

  /// Mapear respuesta de The Movie Db a entidad local cuando vienen en lista
  static Movie movieDBtoEntity(MovieFromMovieDB movieDb) => Movie(
    adult: movieDb.adult ?? false,
    backdropPath: (movieDb.backdropPath != '')
      ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
      : '',
    genreIds: movieDb.genreIds.map( (e) => e.toString()).toList(),
    id: movieDb.id,
    originalLanguage: movieDb.originalLanguage,
    originalTitle: movieDb.originalTitle,
    overview: movieDb.overview ?? '',
    popularity: movieDb.popularity,
    posterPath: (movieDb.posterPath != '')
      ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
      : 'no-poster',
    releaseDate: movieDb.releaseDate ?? DateTime.now(),
    title: movieDb.title,
    video: movieDb.video,
    voteAverage: movieDb.voteAverage,
    voteCount: movieDb.voteCount
  );

  /// Mapear respuesta de The Movie Db a entidad local cuando se solicitan detalles
  static Movie movieDetailsDBtoEntity(MovieDetails movieDb) => Movie(
    adult: movieDb.adult ?? false,
    backdropPath: (movieDb.backdropPath != '')
      ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
      : '',
    genreIds: movieDb.genres?.map( (e) => e.name.toString()).toList() ?? [],
    id: movieDb.id ?? 0,
    originalLanguage: movieDb.originalLanguage ??  'no-data',
    originalTitle: movieDb.originalTitle ?? 'no-data',
    overview: movieDb.overview ?? '',
    popularity: movieDb.popularity ?? 0.0,
    posterPath: (movieDb.posterPath != '')
      ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
      : 'no-poster',
    releaseDate: movieDb.releaseDate ?? DateTime.now(),
    title: movieDb.title ?? 'no-data',
    video: movieDb.video ?? false,
    voteAverage: movieDb.voteAverage ?? 0,
    voteCount: movieDb.voteCount ?? 0
  );
}

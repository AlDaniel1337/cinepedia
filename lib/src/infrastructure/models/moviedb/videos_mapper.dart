import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/infrastructure/models/moviedb/videos_response.dart';

/// Pasar informacion de la respuesta a la entidad local
class VideosMapper {

  /// Mapear respuesta de The Movie Db [videos] a entidad local
  static Videos movieToEntity(MovieTheMovieDB movie) => Videos(
    name: movie.name ?? '',
    site: movie.site ?? '',
    key:  movie.key  ?? '',
  );
}

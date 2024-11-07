import 'package:cinepedia/src/domain/entities/actor.dart';
import 'package:cinepedia/src/infrastructure/models/moviedb/credits_response.dart';

/// Pasar informacion de la respuesta a la entidad local
class ActorMapper {

  /// Mapear respuesta de The Movie Db [credits] a entidad local
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id ?? -1, 
    name: cast.name ?? "no-data", 
    profilePath: cast.profilePath != null
      ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
      : 'no-data',
    character: cast.character
  );
}

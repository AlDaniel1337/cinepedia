//^ Fuente de datos

import 'package:cinepedia/src/config/plugins/env_variables.dart';
import 'package:cinepedia/src/config/plugins/http.dart';
import 'package:cinepedia/src/domain/datasources/actors.datasource.dart';
import 'package:cinepedia/src/domain/entities/actor.dart';
import 'package:cinepedia/src/infrastructure/models/moviedb/actor_mapper.dart';
import 'package:cinepedia/src/infrastructure/models/moviedb/credits_response.dart';

/// implementacion de la clases definidas en 
class ActorMoviedbDatasource extends ActorsDatasource {

  /// Configuracion del plugin http para este datasource
  final HttpAdapter _httpAdapter = HttpAdapter(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': EnvVariablesManager.getEnvVariable(value: EnvKeys.movieDbKey),
      'language': 'es-MX',
    }
  );


  /// Obtener cast de una pelicula
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {

    String path = "/movie/$movieId/credits";
    
    //* Peticion http
    final response = await _httpAdapter.get(path: path);
    
    //+ Respuesta vacia
    if( response.statusCode != 200 ) throw Exception("Cast with id $movieId not found");
    
    //* Pasar respuesta a modelo de MovieDb [cast]
    final castDetails = CreditsResponse.fromMap( response.data );

    //* Pasar modelo (MovieDb) a entidad local (usando el mapper)
    final List<Actor> movies = castDetails.cast!
    .map( (actor) => ActorMapper.castToEntity(actor) ).toList();

    return movies;
  }
  

}

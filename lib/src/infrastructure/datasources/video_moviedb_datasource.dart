//^ Fuente de datos

import 'package:cinepedia/src/config/plugins/env_variables.dart';
import 'package:cinepedia/src/config/plugins/http.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/infrastructure/models/moviedb/videos_mapper.dart';
import 'package:cinepedia/src/infrastructure/models/moviedb/videos_response.dart';

/// implementacion de la clases definidas en 
class VideoMoviedbDatasource extends VideosDatasource {

  /// Configuracion del plugin http para este datasource
  final HttpAdapter _httpAdapter = HttpAdapter(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': EnvVariablesManager.getEnvVariable(value: EnvKeys.movieDbKey),
      'language': 'es-MX',
    }
  );

  
  @override
  Future<List<Videos>> getVideosByMovie(String movieId) async {
    
    String path = "/movie/$movieId/videos";
    
    //* Peticion http
    final response = await _httpAdapter.get(path: path);
    
    //+ Respuesta vacia
    if( response.statusCode != 200 ) throw Exception("Videos with id $movieId not found");
    
    //* Pasar respuesta a modelo de MovieDb [cast]
    final videosDetails = VideosResponse.fromMap( response.data );

    //* Pasar modelo (MovieDb) a entidad local (usando el mapper)
    final List<Videos> videos = videosDetails.results!
    .map( (actor) => VideosMapper.movieToEntity(actor) ).toList();

    return videos;
  }
  

}

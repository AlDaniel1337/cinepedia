import 'package:cinepedia/src/domain/entities/videos.dart';

/// Definir funciones que se ocuparan para las peticiones
abstract class VideosDatasource {

  /// Definir como debe de lucir la peticion [getVideosByMovie]
  Future<List<Videos>> getVideosByMovie(String movieId);

}
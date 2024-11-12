import 'package:cinepedia/src/domain/domain.dart';

class VideosRepositoryImpl extends VideosRepository {

  final VideosDatasource datasource;

  VideosRepositoryImpl({
    required this.datasource
  });

  @override
  Future<List<Videos>> getVideosByMovie(String movieId) {
    return datasource.getVideosByMovie(movieId);
  }

}
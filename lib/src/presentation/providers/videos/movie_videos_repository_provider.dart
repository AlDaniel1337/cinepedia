import 'package:cinepedia/src/infrastructure/datasources/video_moviedb_datasource.dart';
import 'package:cinepedia/src/infrastructure/repositories/videos_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieVideosRepositoryProvider = Provider( (ref) {
  return VideosRepositoryImpl(datasource: VideoMoviedbDatasource());
});
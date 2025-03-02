import 'package:cinepedia/src/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinepedia/src/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider( (ref) {
  return ActorRepositoryImpl(datasource: ActorMoviedbDatasource());
});
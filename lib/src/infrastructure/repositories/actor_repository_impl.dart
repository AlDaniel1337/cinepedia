import 'package:cinepedia/src/domain/datasources/actors.datasource.dart';
import 'package:cinepedia/src/domain/entities/actor.dart';
import 'package:cinepedia/src/domain/repositories/actors.repository.dart';

class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDatasource datasource;

  ActorRepositoryImpl({
    required this.datasource
  });

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }

}
//===========================================================
//*     ENTIDAD LOCAL DE PELICULAS
//?     Se agrega Isar para mantener infomacion en una base de datos local
//LINK  https://isar.dev/es/tutorials/quickstart.html
//
//NOTE: Ejecutar flutter pub run build_runner build
//      Esto generara el archivo movie.g.dart 
//!     ESTE ARCHIVO NO SE MODIFICA
//===========================================================

import 'package:isar/isar.dart';

part 'movie.g.dart';

/// Entidad local de peliculas
@collection //? Base de datos local
class Movie {

  Id? isarId; //? Base de datos local

  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount
  });
}
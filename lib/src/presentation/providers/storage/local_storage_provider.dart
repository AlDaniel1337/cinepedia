//===========================================================
//* MANEJAR STORAGE (db local)
//===========================================================*/

import 'package:cinepedia/src/infrastructure/datasources/local_storage/isar.datasource.dart';
import 'package:cinepedia/src/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider( (ref) {
  return LocalStorageRepositoryImpl(datasource: IsarDatasource());
});

/// Proveedor para revisar si una pelicula es favorita o no
final isFavoriteProvider = FutureProvider.family.autoDispose( (ref, int movieId) {

  // Obtener provider que maneja la db local
  final localStorage = ref.watch( localStorageRepositoryProvider );
  
  // revisar y regresar si la pelicula es favorita
  return localStorage.isMovieFavorite( movieId );

});
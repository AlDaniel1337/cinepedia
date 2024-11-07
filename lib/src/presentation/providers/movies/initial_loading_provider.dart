//===========================================================
//* INDICAR SI TERMINO DE CARGAR LAS PELICULAS
//===========================================================*/

import 'package:cinepedia/src/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingPtovider = Provider<bool>( (ref) {

  //# Revisar contenido de los otros providers
  final step1 = ref.watch( nowPlayingMoviesProvider ).isEmpty;
  final step2 = ref.watch( upcomingMoviesProvider   ).isEmpty;

  //+ Sigue cargando
  if(step1 || step2 ) return true;
  
  //- Termino de cargar
  return false;
});
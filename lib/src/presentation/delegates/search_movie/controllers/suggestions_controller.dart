import 'dart:async';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:get/get.dart';

class SuggestionsController extends GetxController{

  StreamController< List<Movie> > debouncerMovies = StreamController.broadcast();
  StreamController< bool > isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;
  List<Movie> moviesCache = [];
  String _queryCache = "";


  /// Realizar peticion despues de un periodo de gracia
  void onQueryChange({ required String query,  required Function searchAction }) {
    
    isLoadingStream.add(true);

    if( debouncerMovies.isClosed ) debouncerMovies = StreamController.broadcast();
    
    //+ Revisar cache y mostrar resultados 
    if(query == _queryCache){
      debouncerMovies.add(moviesCache);
      return;
    }
    
    setTimer(query: query, searchAction: searchAction);
  }


  /// Establecer periodo de gracia para realizar peticion para obtener nuevas peliculas
  void setTimer({ required String query,  required Function searchAction }){

    //+ Limpiar timer (reiniciarlo)
    if( _debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();
    
    // Establecer tiempo de espera
    _debounceTimer = Timer( const Duration( milliseconds:  1000), () async {
      
      if( query.isEmpty ){
        isLoadingStream.add(false);
        debouncerMovies.add([]);
        return;
      }

      //* Realizar peticion para obtener más péliculas
      final movies = await searchAction(query);
      debouncerMovies.add(movies);

      _saveQuery(query);
      moviesCache = movies;
      isLoadingStream.add(false);

    });
  }


  /// Limpiar streams del debouncer
  void clearStreams() => debouncerMovies.close();

  /// Guardar query usado para buscar las peliculas
  void _saveQuery(String query) => _queryCache = query;


  /// Obtener query usado para buscar las peliculas
  String get getQuery => _queryCache;


  /// Limpiar query usado
  void cleanQuery() => _queryCache = "";
  
}
import 'package:cinepedia/src/domain/domain.dart';
import 'package:get/get.dart';

class PopularPageController extends GetxController{

  bool _isLoading  = false;
  bool _isLastPage = false;

  /// Cargar siguiente pagina de peliculas favoritas
  void loadNextPage({ required Future< List<Movie> > Function() loadMoreMovies  }) async {

    if(_isLoading || _isLastPage) return;
    _isLoading = true;

    final movies = await loadMoreMovies();
    _isLoading = false;

    if(movies.isEmpty) _isLastPage = true;
    
  }
  
}
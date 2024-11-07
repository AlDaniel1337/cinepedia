import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/delegates/search_movie/controllers/suggestions_controller.dart';
import 'package:cinepedia/src/presentation/delegates/search_movie/widgets/clear_button.dart';
import 'package:cinepedia/src/presentation/delegates/search_movie/widgets/close_button.dart';
import 'package:cinepedia/src/presentation/delegates/search_movie/widgets/suggestions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//! Caso de uso
typedef SearchMoviesCallback = Future<List<Movie>> Function( String query );

SuggestionsController _suggestionsController = Get.put(SuggestionsController());

class SearchMovieDelegate extends SearchDelegate< Movie? > {

  final SearchMoviesCallback searchMoviesCallback;

  SearchMovieDelegate({
    required this.searchMoviesCallback,
  });

  /// Titulo en la busqueda
  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // const Text("buildActions")

      ClearBtn( 
        onPressed: () {
          query = '';
          _suggestionsController.cleanQuery();
        },
        show: query.isNotEmpty,
      )

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //return const Text("buildLeading");
    return CloseBtn(
      onPressed: () {
        _suggestionsController.clearStreams();
        close( context, null );
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResults();
  }

  /// Crear widget con resultados
  Widget _buildResults(){

    print(query);
    if(query.isEmpty) return const Text("");

    return MoviesSuggestions(
      searchAction: searchMoviesCallback,
      query: query,
      onMovieSelected: (context, movie){
        _suggestionsController.clearStreams();
        close(context, movie); //? Funcion propia del delegate
      }
    );
  }
  
}
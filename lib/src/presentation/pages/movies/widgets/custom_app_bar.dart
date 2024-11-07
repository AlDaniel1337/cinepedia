import 'package:cinepedia/src/config/router/app_router.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/delegates/search_movie/controllers/suggestions_controller.dart';
import 'package:cinepedia/src/presentation/delegates/search_movie/search_movie_delegate.dart';
import 'package:cinepedia/src/presentation/pages/movie/movie_page.dart';
import 'package:cinepedia/src/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



SuggestionsController _suggestionsController = Get.put(SuggestionsController());

class CustomAppBar extends ConsumerWidget {
   
  const CustomAppBar({super.key});
  
  @override
  Widget build(BuildContext context, ref) {

    //* Obtener tema
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final titleStyle = theme.textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [

              Icon( Icons.movie_outlined, color: colors.primary, ),
              const SizedBox( width: 5 ),
              Text('Cinepedia', style: titleStyle),

              const Spacer(),

              // Buscador
              IconButton(
                onPressed: () {          
                  
                  //* Obtener provider
                  final movieRepository = ref.read( movieRepositoryProvider );        

                  //! Buscar pelicula
                  showSearch<Movie?>(
                    query: _suggestionsController.getQuery,
                    context: context, 
                    delegate: SearchMovieDelegate(
                      searchMoviesCallback: movieRepository.searchMovies,
                    )
                  ).then( (movie) {
                    
                    //+ Navegar a la pelicula seleccionada (si se selecciono)
                    if(movie != null){
                      Routes.goToPageWithParams(
                        page: MoviePage.route, 
                        params: {
                          MoviePageParamsKeys.movieId: movie.id
                        }
                      );
                    }

                  });
                  
                }, 

                icon: const Icon( Icons.search )
              ),


            ],
          ),
        ),
      )
    );
  }
}

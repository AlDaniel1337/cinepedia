import 'package:cinepedia/src/config/router/app_router.dart';
import 'package:cinepedia/src/config/plugins/animations.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/pages/pages.dart';
import 'package:flutter/material.dart';

/// Cuerpo principal para los elementos pequeños (favoritos y populares)
class MoviePosterLink extends StatelessWidget {

  final Movie movie;
   
  const MoviePosterLink({super.key, required this.movie});
  
  @override
  Widget build(BuildContext context) {
    return FadeInUpAnimation(
      child: GestureDetector(
        onTap: () => Routes.goToPageWithParams(
          page: MoviePage.route, 
          params: {
            MoviePageParamsKeys.movieId: movie.id
          }
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.posterPath),
        ),
      ),
    );
  }
}
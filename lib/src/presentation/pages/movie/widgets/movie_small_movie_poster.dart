import 'package:cinepedia/src/config/plugins/animations.dart';
import 'package:cinepedia/src/config/plugins/shimmer.dart';
import 'package:cinepedia/src/config/router/app_router.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/pages/movie/movie_page.dart';
import 'package:flutter/material.dart';

/// Contenedor con el listado de actores
class MovieSmallMoviePoster extends StatelessWidget {

  final List<Movie> movies;
   
  const MovieSmallMoviePoster({
    super.key, 
    required this.movies,
  });
  
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder:(context, index) => _Body(movie: movies[index]),
      ),
    );
  }
}

class _Body extends StatelessWidget {

  final Movie movie;
   
  const _Body({required this.movie});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        //TODO revisar porque no va a pagina de pelicula
        Routes.goToPageWithParams(
          page: MoviePage.route, 
          params: {
            MoviePageParamsKeys.movieId: movie.id
          }
        );
      },
      
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 135,
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            // Foto
            _MoviePoster(movie: movie),
            const SizedBox(height: 5),
      
            // Nombre
            Text(movie.title, maxLines: 2)
          ],
        )
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
    
        // Imagen
        FadeInRightAnimation(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: movie.posterPath != 'no-poster'
            ? Image.network(
                movie.posterPath,
                width: 135,
                height: 180,
                fit: BoxFit.cover,
              )
            : const ShimmerPlugin( 
              size: Size(135, 180),
              child: Icon( Icons.local_movies, size: 120, ),
            ),
          ),
        ),
        
      ],
    );
  }
}
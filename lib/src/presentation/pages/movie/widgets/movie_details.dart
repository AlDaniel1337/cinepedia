import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/movie_description.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/movie_genders.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/movie_video.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {

  final Movie movie;
  final List<Movie> recommendedMovies;
  final List<Movie> similarMovies;
   
  const MovieDetails({
    super.key, 
    required this.movie,
    required this.recommendedMovies,
    required this.similarMovies,
  });
  
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        MovieDescription(movie: movie),
        MovieGenders(movie: movie),
        MovieActors(movieId: movie.id), // Listado de actores
        // Video
        MovieVideo(movieId: movie.id),

        const SizedBox(height: 40),

        // Listado de peliculas
        const _SubTitle( subtitle: "Recomendaciones"),
        MovieSmallMoviePoster(movies: recommendedMovies),
        const _SubTitle( subtitle: "Similares"),
        MovieSmallMoviePoster(movies: similarMovies),

        const SizedBox( height: 50 ),

      ],
    );
  }
}


class _SubTitle extends StatelessWidget {

  final String subtitle;
   
  const _SubTitle({required this.subtitle});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(subtitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
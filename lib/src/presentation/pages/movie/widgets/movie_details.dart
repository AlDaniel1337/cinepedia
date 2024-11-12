import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/movie_description.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/movie_genders.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/movie_video.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {

  final Movie movie;
   
  const MovieDetails({
    super.key, 
    required this.movie,
  });
  
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        MovieDescription(movie: movie),
        MovieGenders(movie: movie),
        MovieActors(movieId: movie.id), // Listado de actores

        MovieVideo(movieId: movie.id),

        const SizedBox( height: 50 ),

      ],
    );
  }
}
import 'package:cinepedia/src/config/helpers/human_formats.dart';
import 'package:cinepedia/src/config/plugins/animations.dart';
import 'package:cinepedia/src/config/plugins/shimmer.dart';
import 'package:cinepedia/src/domain/domain.dart';
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
   
  const _Body({super.key, required this.movie});
  
  @override
  Widget build(BuildContext context) {
    return Container(
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

    //* Obtener estilo
    final textStyle = Theme.of(context).textTheme;

    return Stack(
      children: [

        // Imagen
        FadeInRightAnimation(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: movie.posterPath != 'no-data'
            ? Image.network(
                movie.posterPath,
                height: 180,
                width: 135,
                fit: BoxFit.cover,
              )
            : const ShimmerPlugin( 
              size: Size(135, 180),
              child: Icon( Icons.person, size: 120, ),
            ),
          ),
        ),
        
        // Calificacion
        FadeInRightAnimation(child: _Rate(movie: movie, textStyle: textStyle)),

      ],
    );
  }
}

class _Rate extends StatelessWidget {
  const _Rate({
    required this.movie,
    required this.textStyle,
  });

  final Movie movie;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      left: 5,
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon( Icons.star_half_outlined, color: Colors.yellow.shade800),
            const SizedBox(width: 3),
            
            Text(
              HumanFormats.number(number: movie.voteAverage), 
              style: textStyle.bodyMedium?.copyWith( color: Colors.yellow.shade800 )
            ),
            const SizedBox(width: 10),
            
          ],
        ),
      ),
    );
  }
}
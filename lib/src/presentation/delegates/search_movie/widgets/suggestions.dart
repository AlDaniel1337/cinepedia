import 'package:cinepedia/src/config/helpers/human_formats.dart';
import 'package:cinepedia/src/config/plugins/animations.dart';
import 'package:cinepedia/src/config/plugins/shimmer.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/delegates/search_movie/controllers/suggestions_controller.dart';
import 'package:cinepedia/src/presentation/delegates/search_movie/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SuggestionsController _suggestionsController = Get.put(SuggestionsController());

class MoviesSuggestions extends StatelessWidget {

  final SearchMoviesCallback searchAction;
  final String query;
  final Function onMovieSelected;

  const MoviesSuggestions({
    super.key,
    required this.searchAction,
    required this.query, 
    required this.onMovieSelected
  });

    
  @override
  Widget build(BuildContext context) {

    _suggestionsController.onQueryChange(query: query, searchAction: searchAction);

    return StreamBuilder(
      initialData: _suggestionsController.moviesCache,
      stream: _suggestionsController.debouncerMovies.stream, 
      builder: (context, snapshot) {
        
        final movies = snapshot.data ?? [];
        
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {

            final movie = movies[index];

            return GestureDetector(
              onTap: () => onMovieSelected(context, movie),
              child: _Body( movie: movie )
            );
          },
        );

      },
    );
  }
}

class _Body extends StatelessWidget {

  final Movie movie;
   
  const _Body({
    super.key,
    required this.movie,
  });
  
  @override
  Widget build(BuildContext context) {

    //* Obtener tema y tamaño
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [

          _Image(size: size, movie: movie),

          const SizedBox(width: 10),

          _Description(size: size, movie: movie, textStyles: textStyles),

        ],
      ),
    );
  }
}


class _Image extends StatelessWidget {
  const _Image({
    super.key,
    required this.size,
    required this.movie,
  });

  final Size size;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: movie.posterPath != "no-poster"
        ? Image.network( movie.posterPath,
            loadingBuilder: (context, child, loadingProgress) => FadeInAnimation(child: child),
          )
        : ShimmerPlugin(size: Size(size.width * 0.2, 115))
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    super.key,
    required this.size,
    required this.movie,
    required this.textStyles,
  });

  final Size size;
  final Movie movie;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text( movie.title, style: textStyles.titleMedium ),
    
          (movie.overview.length > 100)
            ? Text('${ movie.overview.substring(0,100)}...')
            : Text( movie.overview ),

            
          Row(
            children: [
              Icon( Icons.star_half_rounded, color: Colors.yellow.shade800 ),
              const SizedBox( width: 5 ),
              Text( HumanFormats.humanReadbleNumber( number: movie.voteAverage ),
                style: textStyles.bodyMedium!.copyWith( color: Colors.yellow.shade900 ),
              )
            ],
          )
        ],
      ),
    );
  }
}
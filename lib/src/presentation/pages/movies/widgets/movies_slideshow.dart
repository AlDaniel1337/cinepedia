import 'package:cinepedia/src/config/plugins/animations.dart';
import 'package:cinepedia/src/config/plugins/card_swiper.dart';
import 'package:cinepedia/src/config/plugins/shimmer.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {

  final List<Movie> movies;
   
  const MoviesSlideshow({
    super.key, 
    required this.movies, 
  });
  
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: CardSwiperPlugin( 
        elements: movies,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
        autoplay: true,
        scale: 0.9,
        viewportFraction: 0.8,
        showPagination: true,
      ),
    );
  }
}


class _Slide extends StatelessWidget {

  final Movie movie;
   
  const _Slide({
    super.key,
    required this.movie
  });
  
  @override
  Widget build(BuildContext context) {

    const double borderRadious = 10;

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadious),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10)
        )
      ]
    );

    return SizedBox(
      // Image
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: DecoratedBox(
          decoration: decoration,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadious + 4),
            child: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress){

                if (loadingProgress != null){
                  return const ShimmerPlugin(size: Size(150, 230));
                }

                return FadeInAnimation(child: child);
              },
            ),
          ),

        ),
      )

    );
  }
}
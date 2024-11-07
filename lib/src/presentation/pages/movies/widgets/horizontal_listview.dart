import 'package:cinepedia/src/config/helpers/human_formats.dart';
import 'package:cinepedia/src/config/plugins/animations.dart';
import 'package:cinepedia/src/config/plugins/shimmer.dart';
import 'package:cinepedia/src/config/router/app_router.dart';
import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/pages/movie/movie_page.dart';
import 'package:flutter/material.dart';

class HorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;
   
  const HorizontalListview({
    super.key, 
    required this.movies, 
    this.title, 
    this.subtitle, 
    this.loadNextPage
  });

  @override
  State<HorizontalListview> createState() => _HorizontalListviewState();
}

class _HorizontalListviewState extends State<HorizontalListview> {

  //* Controlador para el scroll (infiniteScroll)
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener((){
      if( widget.loadNextPage == null ) return;
      if( scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent ){
        widget.loadNextPage!();
      }
    });

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if( widget.title != null || widget.subtitle != null)
          _Title( title: widget.title, subTitle: widget.subtitle, ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => FadeInRightAnimation(child: _Slide( movie: widget.movies[index], )),
            )
          )

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;
   
  const _Slide({required this.movie});
  
  @override
  Widget build(BuildContext context) {

    //* Obtener estilo
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 8 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // Imagen
          GestureDetector(
            onTap: () => Routes.goToPageWithParams(
              page: MoviePage.route, 
              params: {
                MoviePageParamsKeys.movieId: movie.id
              }
            ),
            child: _Image(movie: movie)
          ),

          const SizedBox(height: 5),

          _SmallTitle(movie: movie, textStyle: textStyle),

          // Calificacion
          Row(
            children: [
              Icon( Icons.star_half_outlined, color: Colors.yellow.shade800),
              const SizedBox(width: 3),
              
              Text(
                HumanFormats.number(number: movie.voteAverage), 
                style: textStyle.bodyMedium?.copyWith( color: Colors.yellow.shade800 )
              ),
              const SizedBox(width: 10),
              
              Text(
                HumanFormats.number(number: movie.popularity, decimalDigits: 0), 
                style: textStyle.bodySmall
              ),
            ],
          ),

        ],
      )
    );
  }
}


class _SmallTitle extends StatelessWidget {
  const _SmallTitle({
    required this.movie,
    required this.textStyle,
  });

  final Movie movie;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Text(movie.title,
        maxLines: 2,
        style: textStyle.titleSmall,
      ),
    );
  }
}


class _Image extends StatelessWidget {
  const _Image({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 230,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network( 
          movie.posterPath,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
    
            if (loadingProgress != null){
              return const ShimmerPlugin(size: Size(150, 230));
            }
            
            return FadeInAnimation(child: child);
          },
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subTitle;
   
  const _Title({this.title, this.subTitle});
  
  @override
  Widget build(BuildContext context) {

    //* Obtener tema
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only( top: 10 ),
      margin: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Row(
        children: [

          if(title != null)
          Text(title!, style: titleStyle),

          const Spacer(),

          if(subTitle != null)
          FilledButton.tonal(
            style: const ButtonStyle( visualDensity: VisualDensity.compact ),
            onPressed: (){}, 
            child: Text(subTitle!)
          )

        ],
      ),
    );
  }
}
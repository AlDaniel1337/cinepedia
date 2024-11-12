import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/domain/entities/actor.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/widgets.dart';
import 'package:cinepedia/src/presentation/pages/movies/widgets/gradient_container.dart';
import 'package:cinepedia/src/presentation/providers/providers.dart';
import 'package:cinepedia/src/presentation/providers/videos/movie_videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

enum MoviePageParamsKeys { movieId }

class MoviePage extends ConsumerStatefulWidget {
  
  static const route = '/movie-page';
  
  //* Obtener parametros
  final movieId = Get.arguments[MoviePageParamsKeys.movieId].toString();
   
  MoviePage({
    super.key, 
  });

  @override
  MoviePageState createState() => MoviePageState();
}

class MoviePageState extends ConsumerState<MoviePage> {

  @override
  void initState() {
    super.initState();
    
    //* Peticiones http
    ref.read( moveInfoProvider.notifier        ).loadMovie(widget.movieId);
    ref.read( actorsByMovieProvider.notifier   ).loadMovieActors(widget.movieId);
    ref.read( videosByMovieIdProvider.notifier ).loadMovieVideos(widget.movieId);

  }

  @override
  Widget build(BuildContext context) {

    //* Revisar cache
    final Movie? movie = ref.watch( moveInfoProvider )[widget.movieId];
    final List<Actor>? actors = ref.watch( actorsByMovieProvider )[widget.movieId];
    final List<Videos>? videos = ref.watch( videosByMovieIdProvider )[widget.movieId];

    return Scaffold(   
      body: Center(
        child: ( movie == null )
        ? const CircularProgressIndicator()
        : _Body( movie: movie, actors: actors, ),
      ),
    );
  }
}


class _Body extends StatelessWidget {

  final Movie movie;
  final List<Actor>? actors;

  const _Body({ required this.movie, this.actors });
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [

        // Header
        _CustomSliverAppBar(movie: movie),

        // Detalles
        SliverList(
          delegate: SliverChildBuilderDelegate( 
            (context, index) => MovieDetails( movie: movie, ), 
            childCount: 1 
          ),
        ),

      ],
    );
  }
}


class _CustomSliverAppBar extends StatelessWidget {

  final Movie movie;
   
  const _CustomSliverAppBar({ required this.movie });
  
  @override
  Widget build(BuildContext context) {

    //* Obtener dimenciones del dispositivo
    final size = MediaQuery.of(context).size;

    return SliverAppBar(

      actions: [
        _FavoriteBtn(movie: movie)
      ],

      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

        // Titulo
        title: MovieTitle(title: movie.title),

        // Imagen
        background: Stack(
          children: [

            // Imagen
            MovieFullImageContainer(url: movie.posterPath),

            // Gradientes
            const GradientContainer(), // Gradiente inferior
            const GradientContainer( // Gradiente izquierdo
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                stops: [0.0, 0.3],
                colors: [
                  Colors.black87,
                  Colors.transparent,
                ]
              ),
            ),
            const GradientContainer( // Gradiente 
              linearGradient: LinearGradient(
                begin: Alignment.topRight,
                stops: [0.0, 0.3],
                colors: [
                  Colors.black87,
                  Colors.transparent,
                ]
              ),
            )
          ],
        ),

      ),
    );
  }
}

class _FavoriteBtn extends ConsumerWidget {

  final Movie movie;

  const _FavoriteBtn({
    required this.movie, 
  });

  @override
  Widget build(BuildContext context, ref) {

    final isFavoriteFuture = ref.watch( isFavoriteProvider( movie.id) );

    return isFavoriteFuture.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace ) => throw UnimplementedError(), 
      data: (isFavorite) => MovieFavoriteBtn( 
        isFavorite: isFavorite, 
        onPressed: () async {

          // realizar peticion
          //ref.read( localStorageRepositoryProvider ).toggleFavorite(movie);
          await ref.read( favoritesMoviesProvider.notifier ).toggleFavorite(movie);

          // invalidar para volver a realizar la peticion
          ref.invalidate( isFavoriteProvider(movie.id) );

        }
      ), 
    );
    
    
  }
}
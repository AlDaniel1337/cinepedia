import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/pages/movies/widgets/custom_app_bar.dart';
import 'package:cinepedia/src/presentation/pages/movies/widgets/horizontal_listview.dart';
import 'package:cinepedia/src/presentation/pages/movies/widgets/movies_slideshow.dart';
import 'package:cinepedia/src/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinepedia/src/presentation/providers/movies/movies_providers.dart';
import 'package:cinepedia/src/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinepedia/src/presentation/widgets/full_screen_loader/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesPage extends StatelessWidget {

  static const route = '/movies-page';
   
  const MoviesPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(   
      body: _Body(),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body({
    super.key,
  });

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {

  @override
  void initState() {
    super.initState();

    //* Cargar primera pagina de peliculas
    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
    ref.read( upcomingMoviesProvider.notifier   ).loadNextPage();
    
  }

  @override
  Widget build(BuildContext context) {

    if( ref.watch( initialLoadingPtovider ) ) return const FullScreenLoader();

    //* Obtener peliculas
    final nowPlayingCarrousel = ref.watch( moviesSlideshowProvider );
    final nowPlayingMovies    = ref.watch( nowPlayingMoviesProvider );
    final upcomingMovies      = ref.watch( upcomingMoviesProvider );
    
    
    return Center( 
      child:_MovieListContainer(
        nowPlayingCarrousel: nowPlayingCarrousel,
        nowPlayingMovies: nowPlayingMovies,
        upcomingMovies: upcomingMovies,
      )
    );
    
  }
}

class _MovieListContainer extends ConsumerWidget {

  final List<Movie> nowPlayingMovies;
  final List<Movie> nowPlayingCarrousel;
  final List<Movie> upcomingMovies;

  const _MovieListContainer({
    required this.nowPlayingMovies, 
    required this.nowPlayingCarrousel,
    required this.upcomingMovies, 
  });
  
  @override
  Widget build(BuildContext context, ref) {

    var date = ref.read( nowPlayingMoviesProvider.notifier ).loadDate();

    return CustomScrollView(

      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
        
                MoviesSlideshow(
                  movies: nowPlayingCarrousel, 
                ),
            
                HorizontalListview(
                  movies: nowPlayingMovies,
                  title: "En cines",
                  subtitle: "${date.$1} ${date.$2}",
                  loadNextPage: () => ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage(),
                ), 
        
                HorizontalListview(
                  movies: upcomingMovies,
                  title: "Próximamente",
                  loadNextPage: () => ref.read( upcomingMoviesProvider.notifier ).loadNextPage(),
                ),

                const SizedBox( height: 50)
            
            
              ],
            );
          },
          childCount: 1
          )
        )
      ]
    );
  }
}
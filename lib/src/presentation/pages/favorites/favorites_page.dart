import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:cinepedia/src/config/plugins/flutter_staggered_grid_view.adapter.dart';
import 'package:cinepedia/src/presentation/pages/favorites/favorite_page_controller.dart';
import 'package:cinepedia/src/presentation/providers/providers.dart';
import 'package:cinepedia/src/presentation/widgets/widgets.dart';

FavoritePageController _favoritePageController = Get.put(FavoritePageController());
class FavoritesPage extends ConsumerStatefulWidget {
   
  const FavoritesPage({super.key});

  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends ConsumerState<FavoritesPage> {

  @override
  void initState() {
    super.initState();

    //* Obtener favoritos de la bd local
    ref.read( favoritesMoviesProvider.notifier ).loadNextPage(); //? Obtener primera pagina
  }

  @override
  Widget build(BuildContext context) {

    //* Obtener provider con las peliculas favoritas
    final favoriteMovies = ref.watch( favoritesMoviesProvider ); 

    return Scaffold(   
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: favoriteMovies.isEmpty 
        ? const _EmptyFavorites()
        : Center(
            child: FlutterStaggeredGridViewAdapter(
            rowElements: 3,
            ySpacing: 10,
            xSpacing: 10,
            children: [...favoriteMovies.values.map( (movie) => MoviePosterLink(movie: movie))],
            infiniteScrollAction: () {
              _favoritePageController.loadNextPage(
                loadMoreMovies: ref.read( favoritesMoviesProvider.notifier ).loadNextPage
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Cuerpo para indicar que no hay favoritos
class _EmptyFavorites extends StatelessWidget {

  const _EmptyFavorites({super.key});
  
  @override
  Widget build(BuildContext context) {

    //* Obtener tema
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon( Icons.favorite_outline_sharp, size: 60, color: colors.primary ),
          Text("Ohhh no!!!", style: TextStyle( fontSize: 30, color: colors.primary ) ),
          const Text("No tienes películas favoritas", style: TextStyle( fontSize: 20, color: Colors.black45 ) ),
        ],
      ),
    );
  }
}
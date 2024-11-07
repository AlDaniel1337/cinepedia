import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:cinepedia/src/presentation/pages/popular/popular_page_controller.dart';
import 'package:cinepedia/src/config/plugins/flutter_staggered_grid_view.adapter.dart';
import 'package:cinepedia/src/presentation/providers/providers.dart';
import 'package:cinepedia/src/presentation/widgets/widgets.dart';

PopularPageController _popularPageController = Get.put(PopularPageController());
class PopularPage extends ConsumerStatefulWidget {
   
  const PopularPage({super.key});

  @override
  PopularPageState createState() => PopularPageState();
}

class PopularPageState extends ConsumerState<PopularPage> {

  @override
  void initState() {
    super.initState();

    // Obtener peliculas populares
    ref.read( popularMoviesProvider.notifier ).loadNextPage(); //? Obtener primera pagina

  }

  @override
  Widget build(BuildContext context) {

    //* Obtener provider con las peliculas favoritas
    final popularMovies = ref.watch( popularMoviesProvider ); 

    return Scaffold(   
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: FlutterStaggeredGridViewAdapter(
            rowElements: 3,
            ySpacing: 10,
            xSpacing: 10,
            children: [...popularMovies.map( (movie) => MoviePosterLink(movie: movie))],
            infiniteScrollAction: () {
              _popularPageController.loadNextPage(
                loadMoreMovies: ref.read( popularMoviesProvider.notifier ).loadNextPage
              );
            },
          ),
        ),
      ),
    );
  }
}
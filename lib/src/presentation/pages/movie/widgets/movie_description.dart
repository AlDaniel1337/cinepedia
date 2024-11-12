import 'package:cinepedia/src/domain/domain.dart';
import 'package:cinepedia/src/presentation/pages/movie/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MovieDescription extends StatelessWidget {
  
  final Movie movie;
   
  const MovieDescription({
    super.key, 
    required this.movie
  });
  
  @override
  Widget build(BuildContext context) {

    //* Obtener dimenciones y tema
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          MovieImageContainer(
            url: movie.posterPath,
            width: size.width * 0.3, 
          ),

          const SizedBox( width: 10 ),

          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( movie.title, style: textStyle.titleLarge ),
                Text( movie.overview )
              ],
            ),
          )

        ],
      ),
    );
  }
}
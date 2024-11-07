import 'package:flutter/material.dart';
import 'package:cinepedia/src/config/plugins/animations.dart';

/// Imagen que se ajusta a el tamaño del padre
class MovieFullImageContainer extends StatelessWidget {

  final String url;
   
  const MovieFullImageContainer({super.key, required this.url});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.network( url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if(loadingProgress != null) return const SizedBox();
          return FadeInAnimation(child: child);
        },
      ),
    );
  }
}

/// Imagen con bordes redondeados
class MovieImageContainer extends StatelessWidget {

  final String url;
  final double width;
   
  const MovieImageContainer({super.key, required this.url, required this.width});
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network( url,
        fit: BoxFit.cover,
        width: width,
        loadingBuilder: (context, child, loadingProgress) {
          if(loadingProgress != null) return const SizedBox();
          return FadeInAnimation(child: child);
        },
      ),
    );
  }
}
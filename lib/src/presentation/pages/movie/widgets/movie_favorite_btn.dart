import 'package:flutter/material.dart';

class MovieFavoriteBtn extends StatelessWidget { 

  final bool isFavorite;
  final void Function()? onPressed;

  const MovieFavoriteBtn({
    super.key, 
    required this.isFavorite, 
    this.onPressed
  });
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: Icon( isFavorite
        ? Icons.favorite_rounded
        : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.white,
      ),
    );
  }
}
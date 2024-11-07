import 'package:cinepedia/src/domain/domain.dart';
import 'package:flutter/material.dart';

class MovieGenders extends StatelessWidget {

  final Movie movie;
   
  const MovieGenders({super.key, required this.movie});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        children: [
          ...movie.genreIds.map( (gender) => Container(
            margin: const EdgeInsets.only(right: 10),
            child: Chip(
              label: Text(gender),
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
            ),
          ))
        ],
      ), 
    );
  }
}
import 'package:flutter/material.dart';

import 'package:cinepedia/src/config/plugins/animations.dart';
import 'package:cinepedia/src/config/plugins/shimmer.dart';
import 'package:cinepedia/src/domain/entities/actor.dart';

class MovieActor extends StatelessWidget {

  final Actor actor;
   
  const MovieActor({super.key, required this.actor});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 135,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Foto
          FadeInRightAnimation(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: actor.profilePath != 'no-data'
              ? Image.network(
                  actor.profilePath,
                  height: 180,
                  width: 135,
                  fit: BoxFit.cover,
                )
              : const ShimmerPlugin( 
                size: Size(135, 180),
                child: Icon( Icons.person, size: 120, ),
              ),
            ),
          ),
          const SizedBox(height: 5),

          // Nombre y personaje
          Text(actor.name, maxLines: 2),
          Text(actor.character ?? '', 
            maxLines: 2,
            style: const TextStyle( fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis ),
          )
        ],
      ),
    );
  }
}
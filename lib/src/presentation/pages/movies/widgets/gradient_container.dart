import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
   
  final LinearGradient? linearGradient;

  const GradientContainer({
    super.key, 

    this.linearGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.7, 1.0],
      colors: [
        Colors.transparent,
        Colors.black87
      ]
    )

  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child:DecoratedBox(
        decoration: BoxDecoration(
          gradient: linearGradient
        )
      )
    );
  }
}
//===========================================================
//* ADAPTACION DEL PAQUETE SHIMMER
//LINK - https://pub.dev/packages/shimmer
//===========================================================

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlugin extends StatelessWidget {

  final Widget? child;
  final Color baseColor;
  final Color highlightColor;
  final Size size;
   
  const ShimmerPlugin({
    super.key, 
    this.child, 
    this.baseColor = const Color.fromARGB(255, 234, 234, 234),
    this.highlightColor = const Color.fromARGB(255, 192, 192, 192), 
    required this.size,
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: child ?? Container( color: Colors.white )
        ),
      ),
    );
  }
}
import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';

class CardSwiperPlugin extends StatelessWidget {

  final List elements;
  final Widget Function(BuildContext, int)? itemBuilder;
  final bool autoplay;
  final double scale;
  final double viewportFraction;
  final bool showPagination;

  const CardSwiperPlugin({
    super.key,
    required this.elements,
    this.itemBuilder, 
    this.autoplay = false, 
    this.scale = 1.0, 
    this.viewportFraction = 1.0,
    this.showPagination = false,
  });
  
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Swiper(
      autoplay: autoplay,
      scale: scale,
      viewportFraction: viewportFraction,
      itemCount: elements.length,
      itemBuilder: itemBuilder,
      pagination: showPagination
      ? SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: Colors.black12
          )
        )
      : null,
    );
  }
}

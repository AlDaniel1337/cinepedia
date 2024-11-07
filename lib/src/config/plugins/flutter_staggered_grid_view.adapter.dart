//LINK - https://pub.dev/packages/flutter_staggered_grid_view/

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class FlutterStaggeredGridViewAdapter extends StatefulWidget {

  final double ySpacing;
  final double xSpacing;
  final int rowElements;
  final List<Widget> children;
  final void Function()? infiniteScrollAction; 

  const FlutterStaggeredGridViewAdapter({
    super.key, 
    this.ySpacing = 4, 
    this.xSpacing = 4, 
    this.rowElements = 2, 
    required this.children, 
    this.infiniteScrollAction, 

  });

  @override
  State<FlutterStaggeredGridViewAdapter> createState() => _FlutterStaggeredGridViewAdapterState();
}

class _FlutterStaggeredGridViewAdapterState extends State<FlutterStaggeredGridViewAdapter> {

  ScrollController scrollController = ScrollController();

  @override
  void initState() {

    //* Infinite scroll
    scrollController.addListener((){ 

      if(widget.infiniteScrollAction == null ) return;

      if(scrollController.position.pixels +100 >= scrollController.position.maxScrollExtent){
        widget.infiniteScrollAction!(); 
      }

    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //* Generar Grid View 
    return MasonryGridView.count(
      controller: scrollController,
      
      crossAxisCount: widget.rowElements, // Elementos por fila
      mainAxisSpacing: widget.ySpacing, // Espacio en X
      crossAxisSpacing: widget.xSpacing, // Espacio en Y
      itemCount: widget.children.length, // Total de elementos

      itemBuilder: (context, index) {

        if(index == 1) {
          return Column(
            children: [
              const SizedBox( height: 30),
              widget.children[index],
            ],
          );
        }

        return widget.children[index];
      }
    );
  }
}
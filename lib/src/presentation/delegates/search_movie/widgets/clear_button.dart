import 'package:cinepedia/src/config/plugins/animations.dart';
import 'package:cinepedia/src/presentation/delegates/search_movie/controllers/suggestions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ClearBtn extends StatelessWidget {

  final void Function()? onPressed;
  final bool show;
   
  const ClearBtn({
    super.key,
    this.onPressed, 
    this.show = true
  });
  
  @override
  Widget build(BuildContext context) {

    SuggestionsController suggestionsController = Get.put(SuggestionsController());

    return StreamBuilder(
      initialData: false,
      stream: suggestionsController.isLoadingStream.stream, 
      builder: (context, snapshot) {
        
        // Indicador de carga
        if( snapshot.data ?? false ){
          return SpinPerfectAnimation(
            child: IconButton(
              onPressed: onPressed, 
              icon: const Icon( Icons.refresh_rounded )
            ),
          );
        }

        // Cerrar
        return FadeInAnimation(
          animate: show,
          child: IconButton(
            onPressed: onPressed, 
            icon: const Icon( Icons.clear_rounded )
          ),
        );

      },
    );


  }
}
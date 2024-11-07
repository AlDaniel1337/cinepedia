import 'package:cinepedia/src/presentation/widgets/full_screen_loader/full_screen_loader_controller.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
   
  const FullScreenLoader({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          StreamBuilder(
            stream: FullScreenLoaderController.getLoadingMessages(), 
            builder:(context, snapshot) {
              if( !snapshot.hasData ) return const Text("Cargando...");
              
              return Text(snapshot.data ?? "Cargando...");
            },
          ),

          const SizedBox(height: 10),
          const CircularProgressIndicator( strokeWidth: 2, ),
        ],
      ),
    );
  }
}
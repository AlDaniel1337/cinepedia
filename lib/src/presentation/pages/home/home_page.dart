import 'package:cinepedia/src/presentation/pages/pages.dart';
import 'package:cinepedia/src/presentation/widgets/navigation_bar/navigation_bar_controller.dart';
import 'package:cinepedia/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NavigationBarController _navigationBarController = Get.put(NavigationBarController());
class MoviesHomePage extends StatelessWidget {

  static const route = '/movies-home-page';  

  final bool keepState;
  
  const MoviesHomePage({
    super.key, 
    this.keepState = false, 
  });
  
  @override
  Widget build(BuildContext context) {

    List<NavigationItem> navElements = [
      NavigationItem(label: "Inicio",     page: const MoviesPage(),    icon: const Icon( Icons.home_max_outlined )),
      NavigationItem(label: "Populares",  page: const PopularPage(),   icon: const Icon( Icons.thumbs_up_down_outlined )),
      NavigationItem(label: "Favoritos",  page: const FavoritesPage(), icon: const Icon( Icons.favorite_border_rounded )),
    ];

    return Obx( () => Scaffold(   
      body: !keepState 
        ? navElements[ _navigationBarController.selectedPage.value ].page
        : IndexedStack(
            index: _navigationBarController.selectedPage.value,
            children: navElements.map( (element) => element.page ).toList(),
          ),

      bottomNavigationBar: CustomButtonNavigationBar(
        navElements: navElements,
      ),
      
    ));
  }
}


class HomePage extends StatelessWidget {
   
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(
         title: const Text('HomePage'),
         centerTitle: true,
      ),
   
      body: const Center(
         child: Text('HomePage'),
      ),
    );
  }
}


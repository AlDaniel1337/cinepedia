import 'package:cinepedia/src/presentation/pages/home/home_page.dart';
import 'package:cinepedia/src/presentation/pages/movie/movie_page.dart';
import 'package:cinepedia/src/presentation/pages/movies/movies_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//~ Interface para los elementos del menu
class MenuOption{
  String title;
  String page;

  MenuOption({required this.title,required this.page,});
}

class Routes{
  
  static const String home = MoviesHomePage.route;

  /// Listado con las rutas de la app
  static List<GetPage> getRoutes(){
    
    List<GetPage> pages = [
      GetPage(name: MoviesHomePage.route, page:() => const MoviesHomePage( keepState: true, )),
      GetPage(name: MoviesPage.route,     page:() => const MoviesPage()),
      GetPage(name: MoviePage.route,      page:() => MoviePage())
    ];
    
    return pages;
  }  
  
  
  //^ ========== NAVEGACIÓN ========== ^\\
  /// Moverse a otra pantalla dejando la anterior en el historial
  static goToPage({required String page}) => Get.toNamed(page);

  /// Moverse a otra pantalla enviando parametros
  static goToPageWithParams({required String page, Object? params}) => Get.toNamed(page, arguments: params);

  /// Cerrar y regresar a la pagina anterior
  static goBackToPage({required BuildContext context}) => Navigator.of(context).pop(true);

}
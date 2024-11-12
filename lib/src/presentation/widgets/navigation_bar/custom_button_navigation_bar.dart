import 'package:cinepedia/src/presentation/widgets/navigation_bar/navigation_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationItem {
  final Icon icon;
  final String label;
  final Widget page;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.page,
  });
}

NavigationBarController navigationBarController = Get.put(NavigationBarController());

class CustomButtonNavigationBar extends StatelessWidget {

  final List<NavigationItem> navElements;
   
  const CustomButtonNavigationBar({
    super.key, 
    required this.navElements
  });
  
  @override
  Widget build(BuildContext context) {

    var selectedPage = navigationBarController.selectedPage.value;

    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      selectedFontSize: 16,
      selectedIconTheme: const IconThemeData(size: 28),
      currentIndex: selectedPage,

      onTap: (value) {
        navigationBarController.selectedPage.value = value;
      },

      items: navElements.map( ( element ) => BottomNavigationBarItem(
        icon: element.icon, 
        label: element.label
      )).toList()
    );
  }
}
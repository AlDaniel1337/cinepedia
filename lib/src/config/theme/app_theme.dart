import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//^ Colores
const _appColorList = <Color> [
  Colors.deepPurple,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent
];


/// Tema principal
class AppTheme {
  
  final int selectedColor;
  final bool isDarkMode;
  
  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false, 
  }): assert( selectedColor > -1, 'ERROR: Selected color must be greater or equal than 0' ),
      assert( selectedColor < _appColorList.length, 'ERROR: Selected color must be less than ${_appColorList.length}' );


  ThemeData getTheme({
    useMaterial3 = true,
  }) => ThemeData(
    useMaterial3: useMaterial3,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: _appColorList[ selectedColor ]
  );

  //? Alterar valores
  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) => AppTheme(
    isDarkMode: isDarkMode ?? this.isDarkMode,
    selectedColor: selectedColor ?? this.selectedColor
  );

}


// SECTION
/*============ Theme provider ============*/

/// Thema personalizado (estado principal)
final themeNotifierProvider = StateNotifierProvider< AppThemeController, AppTheme >( 
  //? Aqui se manda la configuracion inicial (si algo esta en memoria se puede enviar aqui)
  (ref) => AppThemeController() 
);

/// Listado inmutable de colores
final colorListProvider = Provider( (ref) => _appColorList );


/*============ Theme controller ============*/
/// Controlador
class AppThemeController extends StateNotifier<AppTheme>{

  /// Crear primera instancia de appTheme
  AppThemeController(): super( AppTheme() );

  /// Cambiar a modo oscuro
  changeDarkMode(){
    state = state.copyWith( isDarkMode: !state.isDarkMode);
  }

  /// Cambiar paleta de colores
  changeSelectedColor({required int selectedIndex}){
    state = state.copyWith( selectedColor: selectedIndex);
  }

}


// SECTION - Glosario
/*
  * Provider: 
    Estados que no cambian
  * StateProvider: 
    Mantener una pieza de estado
  * StateNotifierProvider
    Mantener un estado u objeto mas elaborado
*/



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:cinepedia/src/config/router/app_router.dart';
import 'package:cinepedia/src/config/theme/app_theme.dart';
import 'package:cinepedia/src/config/plugins/env_variables.dart';

Future<void> main() async {
  
  //* Asegurarce que los Widgets esten inicializados
  WidgetsFlutterBinding.ensureInitialized();

  
  //* Obtener variables de entorno
  await EnvVariablesManager.loadEnvVariables();

  //! Orientaciones permitidas
  //? Con este comando se puede bloquear la orientacion
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);


  runApp(const RiverpodApp());
}


// [Agregar gestor de estados Riverpod]
class RiverpodApp extends StatelessWidget {
  const RiverpodApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MyApp()
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {

    //* Obtener tema
    final AppTheme appThemeRiverpod = ref.watch( themeNotifierProvider );

    // [Agregar gestor de estados GetX]
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Diseños',
      initialRoute: Routes.home,
      getPages: Routes.getRoutes(),
      navigatorKey: Get.key,
      theme: appThemeRiverpod.getTheme()
    );
  }
}

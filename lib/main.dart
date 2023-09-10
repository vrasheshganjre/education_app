import 'package:education_app/bindings/initial_bindings.dart';
import 'package:education_app/configs/themes/app_dark_theme.dart';
import 'package:education_app/controllers/theme_controller.dart';
import 'package:education_app/data_uploader_screen.dart';
import 'package:education_app/firebase_options.dart';
import 'package:education_app/routes/app_routes.dart';
import 'package:education_app/screens/introduction/introduction.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'configs/themes/app_light_theme.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Get.find<ThemeController>().lightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}

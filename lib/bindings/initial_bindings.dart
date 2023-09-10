import 'package:education_app/controllers/auth_controller.dart';
import 'package:education_app/controllers/theme_controller.dart';
import 'package:education_app/services/firebase_storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() async {
    await WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.put(FirebaseStorageService());
  }
}

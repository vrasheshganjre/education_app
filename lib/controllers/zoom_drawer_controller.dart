import 'package:education_app/controllers/auth_controller.dart';
import "package:get/get.dart";
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    // TODO: implement onReady
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signIn() {}

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void website() {}

  void email() {
    final Uri emailLaunchUri =
        Uri(scheme: "mailto", path: "ganjre.vishu28@gmail.com");
    _launch(emailLaunchUri);
  }

  _launch(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'could not launch $url';
    }
  }
}

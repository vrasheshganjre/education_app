import "package:education_app/controllers/auth_controller.dart";
import "package:education_app/model/question_paper_model.dart";
import "package:education_app/services/firebase_storage_service.dart";
import "package:get/get.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import "../../firebase/references.dart";
import "../../screens/question/question_screen.dart";

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;

  @override
  void onReady() {
    // TODO: implement onReady
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ["biology", "chemistry", "maths", "physics"];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        print(imgUrl);
        paper.imageUrl = imgUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print(e);
    }
  }

  void navigateToQuestions(
      {required QuestionPaperModel paper, bool tryAgain = false}) {
    AuthController _authController = Get.find<AuthController>();

    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.offAllNamed("/home");
        Get.toNamed(QuestionScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
    } else {
      print(paper.title);
      _authController.showLoginAlertDialog();
    }
  }
}

import 'package:education_app/controllers/question_papers/question_controller.dart';
import 'package:education_app/controllers/question_papers/question_paper_controller.dart';
import 'package:education_app/controllers/zoom_drawer_controller.dart';
import 'package:education_app/screens/home/home_screen.dart';
import 'package:education_app/screens/introduction/introduction.dart';
import 'package:education_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/login/login_screen.dart';
import '../screens/question/answer_check_screen.dart';
import '../screens/question/question_screen.dart';
import '../screens/question/result_screen.dart';
import '../screens/question/test_overview_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
            name: "/introduction", page: () => const AppIntroductionScreen()),
        GetPage(
            name: "/home",
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
        GetPage(name: LoginScreen.routeName, page: (() => const LoginScreen())),
        GetPage(
            name: QuestionScreen.routeName,
            page: (() => const QuestionScreen()),
            binding: BindingsBuilder(() {
              Get.put<QuestionController>(QuestionController());
            })),
        GetPage(
            name: TestOverviewScreen.routeName,
            page: (() => const TestOverviewScreen())),
        GetPage(
            name: ResultScreen.routeName, page: (() => const ResultScreen())),
        GetPage(
            name: AnswerCheckScreen.routeName, page: (() => const AnswerCheckScreen()))
      ];
}

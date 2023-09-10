import 'package:education_app/configs/themes/custom_text_styles.dart';
import 'package:education_app/configs/themes/ui_parameters.dart';
import 'package:education_app/controllers/question_papers/question_controller_extension.dart';
import 'package:education_app/screens/question/answer_check_screen.dart';
import 'package:education_app/widget/common/custom_app_bar.dart';
import 'package:education_app/widget/content_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/question_papers/question_controller.dart';
import '../../widget/common/background_decoration.dart';
import '../../widget/common/main_button.dart';
import '../../widget/question/answer_card.dart';
import '../../widget/question/question_number_card.dart';
import '../home/home_screen.dart';

class ResultScreen extends GetView<QuestionController> {
  const ResultScreen({super.key});
  static const String routeName = "/resultScreen";
  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;

    return Scaffold(
      appBar: CustomAppBar(
        leading: const SizedBox(
          height: 100,
        ),
        title: controller.correctQuestionString,
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundDecoration(
          child: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ContentArea(
                    child: Column(
              children: [
                SvgPicture.asset('assets/images/bulb.svg'),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    "Congratulations",
                    style: headerText.copyWith(color: _textColor),
                  ),
                ),
                Text("You have got ${controller.points} score",
                    style: TextStyle(
                      color: _textColor,
                    )),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                    "Tap below question numbers to view correct answers"),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                    child: GridView.builder(
                        itemCount: controller.allQuestions.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 75,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (_, index) {
                          final _question = controller.allQuestions[index];
                          AnswerStatus _answerStatus = AnswerStatus.notAnswered;
                          final _selectedAnswer = _question.selectedAnswer;
                          final _correctAnswer = _question.correctAnswer;
                          if (_selectedAnswer == _correctAnswer) {
                            _answerStatus = AnswerStatus.correct;
                          } else if (_selectedAnswer == null) {
                            _answerStatus = AnswerStatus.notAnswered;
                          } else {
                            _answerStatus = AnswerStatus.wrong;
                          }
                          return QuestionNumberCard(
                              index: index,
                              onTap: () {
                                controller.jumpToQuestion(index,
                                    isGoBack: false);
                                Get.toNamed(AnswerCheckScreen.routeName);
                              },
                              status: _answerStatus);
                        }))
              ],
            ))),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: Row(
                  children: [
                    Visibility(
                        visible: controller.correctQuestionCount !=
                            controller.allQuestions.length,
                        child: Expanded(
                            child: MainButton(
                          onTap: () {
                            controller.tryAgain();
                          },
                          title: "Try Again",
                        ))),
                    Expanded(
                        child: MainButton(
                            onTap: () {
                              Get.offAllNamed("/home");
                            },
                            title: "Go to gome"))
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

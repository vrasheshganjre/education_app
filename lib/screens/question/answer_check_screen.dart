import 'package:education_app/controllers/question_papers/question_controller.dart';
import 'package:education_app/firebase/loading_status.dart';
import 'package:education_app/screens/question/result_screen.dart';
import 'package:education_app/widget/common/question_placeholder.dart';
import 'package:education_app/widget/question/count_down.dart';
import 'package:education_app/screens/question/test_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_colors.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../widget/common/background_decoration.dart';
import '../../widget/common/custom_app_bar.dart';
import '../../widget/common/main_button.dart';
import '../../widget/content_area.dart';
import '../../widget/question/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionController> {
  const AnswerCheckScreen({super.key});

  static const String routeName = "/answerCheckScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() => Text(
              """Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}""",
              style: appBarTS,
            )),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(() => SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: ContentArea(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Center(
                            child: Text(
                          controller.currentQuestion.value!.question,
                          style: questionTS,
                        )),
                        GetBuilder<QuestionController>(
                            id: 'answer_review_list',
                            builder: (context) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 25.0),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final answer = controller
                                        .currentQuestion.value!.answers[index];
                                    final selectedAnswer = controller
                                        .currentQuestion.value!.selectedAnswer;
                                    final correctAnswer = controller
                                        .currentQuestion.value!.correctAnswer;
                                    Color? color;
                                    if (answer.identifier == correctAnswer) {
                                      color = correctAnswerColor;
                                    } else if (answer.identifier ==
                                            selectedAnswer &&
                                        correctAnswer != selectedAnswer) {
                                      color = wrongAnswerColor;
                                    } else if (correctAnswer !=
                                        selectedAnswer) {}
                                    return AnswerCard(
                                      color: color,
                                      answer:
                                          "${answer.identifier}. ${answer.answer}",
                                      onTap: () {},
                                      isSelected: answer.identifier ==
                                          controller.currentQuestion.value!
                                              .selectedAnswer,
                                    );
                                  },
                                  separatorBuilder: ((context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      )),
                                  itemCount: controller
                                      .currentQuestion.value!.answers.length);
                            }),
                      ],
                    )),
                  )),
                ],
              ),
            )),
      ),
    );
  }
}

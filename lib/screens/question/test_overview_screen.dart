import 'package:education_app/configs/themes/ui_parameters.dart';
import 'package:education_app/widget/common/custom_app_bar.dart';
import 'package:education_app/widget/content_area.dart';
import 'package:education_app/widget/question/answer_card.dart';
import 'package:education_app/widget/question/question_number_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/question_papers/question_controller.dart';
import '../../widget/common/main_button.dart';
import '../../widget/common/background_decoration.dart';
import '../../widget/common/main_button.dart';
import '../../widget/question/count_down.dart';

class TestOverviewScreen extends GetView<QuestionController> {
  const TestOverviewScreen({super.key});
  static const String routeName = "/testoverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.answeredQuestion,
      ),
      body: BackgroundDecoration(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: ContentArea(
                      child: Column(
                children: [
                  Row(
                    children: [
                      Obx(() => CountDownTimer(
                            time: '${controller.time.value} Remaining',
                            color: UIParameters.isDarkMode()
                                ? Theme.of(context).textTheme.bodyLarge!.color
                                : Theme.of(context).primaryColor,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: GridView.builder(
                          itemCount: controller.allQuestions.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: Get.width ~/ 75,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemBuilder: (_, index) {
                            AnswerStatus? _answerStatus;
                            if (controller.allQuestions[index].selectedAnswer !=
                                null) {
                              _answerStatus = AnswerStatus.answered;
                            }
                            return QuestionNumberCard(
                              index: index + 1,
                              status: _answerStatus,
                              onTap: () {
                                controller.jumpToQuestion(index);
                              },
                            );
                          }))
                ],
              ))),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: MainButton(
                    onTap: () {
                      controller.completeTest();
                    },
                    title: 'Complete',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

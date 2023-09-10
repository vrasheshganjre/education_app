import 'package:education_app/controllers/question_papers/question_controller.dart';
import 'package:education_app/firebase/loading_status.dart';
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

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({super.key});

  static const String routeName = "/questionScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: const ShapeDecoration(
              shape: StadiumBorder(
                  side: BorderSide(color: onSurfaceTextColor, width: 2))),
          child: Obx(() => CountDownTimer(
                time: controller.time.value,
                color: onSurfaceTextColor,
              )),
        ),
        showActionIcon: true,
        titleWidget: Obx(() => Text(
              """Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}""",
              style: appBarTS,
            )),
      ),
      body: BackgroundDecoration(
        child: Obx(() => SafeArea(
              child: Column(
                children: [
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    const Expanded(
                        child: ContentArea(child: QuestionScreenHolder())),
                  if (controller.loadingStatus.value == LoadingStatus.completed)
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
                              id: 'answers_list',
                              builder: (context) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 25.0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final answer = controller.currentQuestion
                                          .value!.answers[index];

                                      return AnswerCard(
                                        answer:
                                            "${answer.identifier}. ${answer.answer}",
                                        onTap: () {
                                          controller.selectedAnswer(
                                              answer.identifier);
                                        },
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
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: UIParameters.mobileScreenPadding,
                      child: Row(children: [
                        Visibility(
                          visible: controller.isFirstQuestion,
                          child: SizedBox(
                            width: 55,
                            height: 55,
                            child: MainButton(
                              onTap: () {
                                controller.prevQuestion();
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Get.isDarkMode
                                    ? onSurfaceTextColor
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                              visible: controller.loadingStatus.value ==
                                  LoadingStatus.completed,
                              child: MainButton(
                                onTap: () {
                                  controller.isLastQuestion
                                      ? Get.toNamed(
                                          TestOverviewScreen.routeName)
                                      : controller.nextQuestion();
                                },
                                title: controller.isLastQuestion
                                    ? "Complete"
                                    : "Next",
                              )),
                        )
                      ]),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

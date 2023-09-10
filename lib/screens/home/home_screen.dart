import 'package:education_app/configs/themes/app_colors.dart';
import 'package:education_app/controllers/question_papers/question_paper_controller.dart';
import 'package:education_app/controllers/zoom_drawer_controller.dart';
import 'package:education_app/screens/home/menu_screen.dart';
import 'package:education_app/screens/home/question_card.dart';
import 'package:education_app/widget/app_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../configs/themes/app_icons.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../widget/content_area.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();

    return Container(
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          drawerScrimColor: Colors.transparent,
          body: GetBuilder<MyZoomDrawerController>(builder: (_) {
            return ZoomDrawer(
              controller: _.zoomDrawerController,
              borderRadius: 50.0,
              showShadow: false,
              menuScreenWidth: double.maxFinite,
              style: DrawerStyle.defaultStyle,
              slideWidth: MediaQuery.of(context).size.width * 0.6,
              angle: 0.0,
              menuBackgroundColor: Colors.transparent,
              menuScreen: MyMenuScreen(),
              mainScreen: Container(
                decoration: BoxDecoration(gradient: mainGradient()),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(mobileScreenPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCircleButton(
                                onTap: controller.toggleDrawer,
                                child: const Icon(AppIcons.menuLeft,
                                    color: Colors.white)),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    AppIcons.peace,
                                  ),
                                  Text(
                                    "Hello Friend",
                                    style: detailText.copyWith(
                                        color: onSurfaceTextColor),
                                  )
                                ],
                              ),
                            ),
                            Text("What do you want to learn today ?",
                                style: headerText)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ContentArea(
                            addPadding: false,
                            child: Obx(
                              () => ListView.separated(
                                  padding: UIParameters.mobileScreenPadding,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return QuestionCard(
                                        model: questionPaperController
                                            .allPapers[index]);
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 20,
                                    );
                                  },
                                  itemCount:
                                      questionPaperController.allPapers.length),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}

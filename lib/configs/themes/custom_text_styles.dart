import 'package:education_app/configs/themes/app_colors.dart';
import 'package:education_app/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextStyle cardTitles(context) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: UIParameters.isDarkMode()
        ? Theme.of(context).textTheme.bodyMedium!.color
        : Theme.of(context).primaryColor);

const questionTS = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
const detailText = TextStyle(fontSize: 12);
const headerText = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: onSurfaceTextColor);
const appBarTS = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, color: onSurfaceTextColor);
TextStyle timerTS = TextStyle(
    letterSpacing: 2,
    color: UIParameters.isDarkMode()
        ? Theme.of(Get.context!).textTheme.bodyLarge!.color
        : Theme.of(Get.context!).primaryColor);

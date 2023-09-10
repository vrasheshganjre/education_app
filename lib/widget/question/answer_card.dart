import 'package:flutter/material.dart';

import '../../configs/themes/app_colors.dart';
import '../../configs/themes/ui_parameters.dart';

enum AnswerStatus { correct, wrong, answered, notAnswered }

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? color;

  const AnswerCard(
      {super.key,
      required this.answer,
      required this.onTap,
      this.color,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: color ??
                (isSelected
                    ? answerSelectedColor()
                    : Theme.of(context).cardColor),
            border: Border.all(
                color: color ??
                    (isSelected
                        ? answerSelectedColor()
                        : answerBorderColor()))),
        child: Text(
          answer,
          style: TextStyle(color: isSelected ? onSurfaceTextColor : null),
        ),
      ),
    );
  }
}

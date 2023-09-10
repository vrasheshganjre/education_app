import 'package:education_app/configs/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CountDownTimer extends StatelessWidget {
  final Color? color;
  final String time;
  const CountDownTimer({super.key, required this.time, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color ?? Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          time,
          style: timerTS.copyWith(color: color),
        )
      ],
    );
  }
}

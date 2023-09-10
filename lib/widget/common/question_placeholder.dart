import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class QuestionScreenHolder extends StatelessWidget {
  const QuestionScreenHolder({super.key});

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: 12.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    var answer = Container(
        width: double.infinity,
        height: 50.0,
        color: Theme.of(context).scaffoldBackgroundColor);

    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.blueGrey.withOpacity(0.5),
        child: EasySeparatedColumn(
            children: [line, line, answer, answer, answer, answer],
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                )));
  }
}

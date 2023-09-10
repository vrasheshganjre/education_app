import 'package:education_app/controllers/question_papers/question_controller.dart';

extension QuestionControllerExtension on QuestionController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctQuestionString =>
      '$correctQuestionCount out of ${allQuestions.length} are correct';

  String get points => ((correctQuestionCount / allQuestions.length) *
          100 *
          ((questionPaperModel.timeSeconds - remainingSeconds) /
              questionPaperModel.timeSeconds) *
          100)
      .toStringAsFixed(2);
}

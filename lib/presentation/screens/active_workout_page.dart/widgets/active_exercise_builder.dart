import 'package:flutter/material.dart';

import '../../../../constants/style.dart';
import '../../../../data/models/exercise.dart';
import 'exercise_in_progress.dart';

class ActiveExerciseBuilder extends StatelessWidget {
  const ActiveExerciseBuilder({
    Key? key,
    required this.exercises,
  }) : super(key: key);

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: const BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25, top: 15, right: 25),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                Exercise exercise = exercises[index];
                return ExerciseInProgress(
                  exercise: exercise,
                  exerIndex: index,
                );
              }),
        ),
      ),
    );
  }
}

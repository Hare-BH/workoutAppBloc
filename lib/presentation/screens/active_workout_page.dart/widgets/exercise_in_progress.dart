import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/style.dart';
import '../../../../data/models/exercise.dart';
import '../../../../logic/active_workout_cubit/active_workout_cubit.dart';

class ExerciseInProgress extends StatelessWidget {
  const ExerciseInProgress({
    Key? key,
    required this.exerIndex,
    required this.exercise,
  }) : super(key: key);

  final Exercise exercise;
  final int exerIndex;

  @override
  Widget build(BuildContext context) {
    late bool? cardState;
    int currentExerIndex =
        BlocProvider.of<ActiveWorkoutCubit>(context).activeExerciseIndex;
    exerIndex == currentExerIndex
        ? cardState = true
        : exerIndex > currentExerIndex
            ? cardState = null
            : cardState = false;

    return Container(
      height: 35,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: kMainColor,
          border: Border.all(
              color: cardState == null
                  ? Colors.white
                  : cardState
                      ? kGreen
                      : Colors.white,
              width: 2),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ]),
      child: Row(
        children: [
          Expanded(
              child: Text(
            '  ${exercise.title}',
            style: const TextStyle(color: Colors.white),
          )),
          Expanded(
            child: Container(
              height: 35,
              color: cardState == false ? kMainColor : kBlueAccent,
              child: Center(
                child: Text(
                  '  ${exercise.sets}x${exercise.reps}    Rest: ${exercise.rest}s',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

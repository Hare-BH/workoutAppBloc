import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/logic/active_workout_cubit/active_workout_cubit.dart';

import '../../../constants/style.dart';
import 'widgets/active_exercise_builder.dart';
import 'widgets/bottom_card.dart';
import 'widgets/workout_done_card.dart';

class ActiveWorkoutPage extends StatelessWidget {
  const ActiveWorkoutPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
        builder: (context, state) {
          if (state is ActiveWorkoutLoaded) {
            return buildActiveWorkout(state);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Column buildActiveWorkout(ActiveWorkoutLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            state.title,
            textAlign: TextAlign.center,
            style: kInProgressTitleStyle,
          ),
        ),
        ActiveExerciseBuilder(exercises: state.exerciseList),
        state.isDone
            ? const WorkoutDoneCard()
            : BottomCard(
                exercise: state.exerciseList[state.index],
                listLength: state.exerciseList.length,
              ),
      ],
    );
  }
}

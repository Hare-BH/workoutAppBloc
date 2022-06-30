import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workouts_app_bloc/logic/active_workout_cubit/active_workout_cubit.dart';
import '../../../../constants/style.dart';
import '../../../../data/models/exercise.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({
    Key? key,
    required this.exercise,
    required this.listLength,
  }) : super(key: key);

  final int listLength;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        color: kMainColor,
        child: Container(
          decoration: BoxDecoration(
            color: kBlueAccent,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                exercise.title,
                style: kInProgressExerciseStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ActiveWorkoutCubit>(context,
                              listen: false)
                          .decrementExerciseIndex();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.angleLeft,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${exercise.sets}x${exercise.reps}',
                    style: kSetsRepsStyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ActiveWorkoutCubit>(context,
                              listen: false)
                          .incrementExerciseIndex();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              buildQuote(),
              buildHomeButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Text buildQuote() {
    return const Text(
      '¨Look in the mirror.\nThat’s your competition.¨ – John Assaraf',
      textAlign: TextAlign.center,
      style: kQuoteStyle,
    );
  }

  GestureDetector buildHomeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ActiveWorkoutCubit>(context, listen: false)
            .resetFields();
        Navigator.pop(context);
      },
      child: const CircleAvatar(
        radius: 30,
        child: FaIcon(
          FontAwesomeIcons.home,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../constants/style.dart';
import '../../../../logic/active_workout_cubit/active_workout_cubit.dart';

class WorkoutDoneCard extends StatelessWidget {
  const WorkoutDoneCard({Key? key}) : super(key: key);

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
              const Text(
                'Workout Finished\nGreat Job',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 27,
                ),
              ),
              buildHomeButton(context),
              const Text(
                '¨Look in the mirror.\nThat’s your competition.¨ – John Assaraf',
                textAlign: TextAlign.center,
                style: kQuoteStyle,
              ),
            ],
          ),
        ),
      ),
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

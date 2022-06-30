import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:workouts_app_bloc/data/models/workout.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';

import '../../../../constants/style.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    Key? key,
    required this.workout,
  }) : super(key: key);

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    void openWorkout() {
      BlocProvider.of<WorkoutBloc>(context, listen: false)
          .add(SetWorkout(workout));
      Navigator.pushNamed(context, '/workout');
    }

    void deleteWorkout() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Workout!'),
          content: Text(
              'Are you sure you want to delete workout named "${workout.title}"?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL')),
            TextButton(
                onPressed: () {
                  BlocProvider.of<WorkoutBloc>(context)
                      .add(DeleteWorkout(workout.id));
                  Navigator.pop(context);
                },
                child: const Text(
                  'DELETE',
                  style: TextStyle(color: Colors.redAccent),
                )),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: openWorkout,
      onLongPress: deleteWorkout,
      child: Container(
        height: 180,
        width: MediaQuery.of(context).size.width - 170,
        margin: const EdgeInsets.only(left: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: kElevatedCardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              workout.title,
              textAlign: TextAlign.left,
              style: kCardText,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'May 12th \n2022',
                    style: kCardTextSmall,
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: InvertColors(
                    child: Image.asset(
                      'images/${workout.category.toLowerCase()}.png',
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

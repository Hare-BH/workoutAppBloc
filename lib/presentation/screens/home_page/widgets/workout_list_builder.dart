import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';

import '../../../../data/models/workout.dart';
import 'workout_card.dart';

class WorkoutList extends StatefulWidget {
  const WorkoutList({Key? key, required this.context, this.isShared = false})
      : super(key: key);

  final BuildContext context;
  final bool isShared;

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: BlocConsumer<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutLoading) {
            return buildLoading();
          }
          if (state is WorkoutListLoaded) {
            return buildWorkoutList(state.workoutList);
          }
          if (state is NoWorkouts) {
            return buildNoWorkouts();
          } else {
            return buildLoading();
          }
        },
        listener: (context, state) {
          if (state is WorkoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
      ),
    );
  }

  Center buildNoWorkouts() {
    return const Center(
      child: Text('No workouts created'),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildWorkoutList(List<Workout> workoutList) {
    final Axis direction = widget.isShared ? Axis.vertical : Axis.horizontal;
    return ListView.builder(
        physics: const ScrollPhysics(
            parent:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())),
        scrollDirection: direction,
        itemCount: workoutList.length,
        itemBuilder: (context, index) {
          final workout = workoutList[index];
          return WorkoutCard(workout: workout);
        });
  }

  @override
  void initState() {
    if (widget.isShared) {
      BlocProvider.of<WorkoutBloc>(widget.context, listen: false)
          .add(LoadSharedWorkoutList());
    } else {
      BlocProvider.of<WorkoutBloc>(widget.context, listen: false)
          .add(LoadWorkoutList());
    }
    super.initState();
  }
}

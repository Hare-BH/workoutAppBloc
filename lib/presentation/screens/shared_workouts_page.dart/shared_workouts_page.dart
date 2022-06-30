import 'package:flutter/material.dart';
import 'package:workouts_app_bloc/presentation/screens/home_page/widgets/workout_list_builder.dart';

import '../../../constants/style.dart';

class SharedWorkoutsPage extends StatelessWidget {
  const SharedWorkoutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Shared Workouts')),
          backgroundColor: kMainColor,
        ),
        body: SafeArea(
          child: WorkoutList(
            context: context,
            isShared: true,
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';
import 'package:workouts_app_bloc/presentation/screens/workout_page/widgets/workout_navbar.dart';

import '../../../constants/style.dart';
import '../add_or_edit_workout_page.dart/widgets/exercise_card.dart';
import 'widgets/category_bar.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: BlocConsumer<WorkoutBloc, WorkoutState>(
        listener: ((context, state) {
          if (state is WorkoutShared) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.blue,
              ),
            );
          }
        }),
        builder: (context, state) {
          if (state is WorkoutLoading) {
            return const CircularProgressIndicator();
          }
          if (state is WorkoutLoaded) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      state.title,
                      style: kCardText,
                    ),
                  ),
                  CategoryBar(category: state.category),
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.exerciseList.length,
                        itemBuilder: (context, index) {
                          ///imported from addoredit_workout_page widgets
                          return ExerciseCard(
                            edit: false,
                            exercise: state.exerciseList[index],
                            color: kBlueAccent,
                          );
                        }),
                  ),
                ],
              ),
            );
          } else {
            return const Text('test1');
          }
        },
      ),
      bottomNavigationBar: const WorkoutNavBar(),
    );
  }
}

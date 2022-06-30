import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';
import '../../../constants/style.dart';
import '../../../data/models/exercise.dart';
import '../../../data/navigation_key.dart';
import 'widgets/add_exercise.dart';
import 'widgets/category_dropdown.dart';
import 'widgets/exercise_card.dart';
import 'widgets/title_text_field.dart';

class AddOrEditPage extends StatelessWidget {
  AddOrEditPage({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _exerciseTitleController =
      TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _restController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(builder: (context, state) {
      if (state is WorkoutLoading) {
        return Container();
      }
      if (state is WorkoutLoaded) {
        //edit
        _titleController.text = state.title;
        return buildAddOrEditPage(
          context: context,
          id: state.id,
          exerciseList: state.exerciseList,
        );
      } else {
        return buildAddOrEditPage(
          //add
          context: context,
          id: '',
          exerciseList: [],
        );
      }
    });
  }

  Scaffold buildAddOrEditPage({
    required BuildContext context,
    required String id,
    required List<Exercise> exerciseList,
  }) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 50.0),
        child: Column(
          children: [
            TitleTextField(titleController: _titleController),
            const CategoryDropdown(),
            buildExerciseList(exerciseList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildShowExerciseModalButton(context),
          buildAddWorkoutButton(context, id),
        ],
      ),
    );
  }

  Expanded buildExerciseList(List<Exercise> exerciseList) {
    return Expanded(
      child: ListView.builder(
          itemCount: exerciseList.length,
          itemBuilder: (context, index) {
            return ExerciseCard(
              edit: true,
              exercise: exerciseList[index],
              color: kBlueAccent,
            );
          }),
    );
  }

  Padding buildAddWorkoutButton(BuildContext context, String workoutId) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FloatingActionButton(
        heroTag: 'addworkout',
        backgroundColor: Colors.white,
        child: const FaIcon(
          FontAwesomeIcons.flagCheckered,
          color: kMainColor,
        ),
        onPressed: () {
          if (workoutId == '') {
            BlocProvider.of<WorkoutBloc>(context, listen: false)
                .add(AddWorkout());
          } else {
            BlocProvider.of<WorkoutBloc>(context, listen: false)
                .add(UpdateWorkout());
          }
          CurvedNavigationBarState navState = NavigationKey.key.currentState!;
          navState.setPage(0);
        },
      ),
    );
  }

  Padding buildShowExerciseModalButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.only(bottom: MediaQuery.of(_).viewInsets.bottom),
                child: AddExerciseModal(
                  blocContext: context,
                  exerciseTitleController: _exerciseTitleController,
                  setsController: _setsController,
                  repsController: _repsController,
                  restController: _restController,
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: kMainColor,
        ),
      ),
    );
  }
}

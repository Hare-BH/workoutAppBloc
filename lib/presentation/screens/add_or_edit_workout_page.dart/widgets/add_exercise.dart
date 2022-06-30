import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/data/models/exercise.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';
import '../../../../constants/style.dart';

class AddExerciseModal extends StatelessWidget {
  const AddExerciseModal({
    Key? key,
    required TextEditingController exerciseTitleController,
    required TextEditingController setsController,
    required TextEditingController repsController,
    required TextEditingController restController,
    required this.blocContext,
  })  : _exerciseTitleController = exerciseTitleController,
        _setsController = setsController,
        _repsController = repsController,
        _restController = restController,
        super(key: key);

  final TextEditingController _exerciseTitleController;
  final TextEditingController _setsController;
  final TextEditingController _repsController;
  final TextEditingController _restController;
  final BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'New Exercise',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: kMainColor,
              ),
            ),
            buildInputField(
              controller: _exerciseTitleController,
              hint: 'Exercise Title',
              autofocus: true,
              keyboardType: TextInputType.text,
            ),
            Row(
              children: [
                Expanded(
                  child: buildInputField(
                    controller: _setsController,
                    hint: 'Sets',
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: buildInputField(
                    controller: _repsController,
                    hint: 'Reps',
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: buildInputField(
                    controller: _restController,
                    hint: 'Rest',
                  ),
                ),
              ],
            ),
            buildAddButton(blocContext),
          ],
        ),
      ),
    );
  }

  MaterialButton buildAddButton(BuildContext context) {
    return MaterialButton(
      color: kMainColor,
      child: const Text(
        'Add',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        final Exercise exercise = Exercise(
          title: _exerciseTitleController.text,
          sets: int.parse(_setsController.text),
          reps: int.parse(_repsController.text),
          rest: int.parse(_restController.text),
        );
        _exerciseTitleController.clear();
        _repsController.clear();
        _restController.clear();
        _setsController.clear();
        BlocProvider.of<WorkoutBloc>(context).add(AddExerciseToList(exercise));
        Navigator.pop(context);
      },
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String hint,
    bool autofocus = false,
    TextInputType keyboardType = TextInputType.number,
  }) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: kMainColor, width: 2),
      ),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        autofocus: autofocus,
        cursorColor: kMainColor,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: kMainColor,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black26,
            fontSize: 16,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

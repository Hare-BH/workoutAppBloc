import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';
import '../../../../constants/style.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    Key? key,
    required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: kMainColor, width: 2),
      ),
      child: TextField(
        controller: _titleController,
        cursorColor: kMainColor,
        textAlign: TextAlign.center,
        style: const TextStyle(color: kMainColor, fontSize: 16.0),
        decoration: InputDecoration(
          hintText: _titleController.text.trim(),
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 16),
          border: InputBorder.none,
        ),
        onChanged: (title) {
          BlocProvider.of<WorkoutBloc>(context).add(
            SetWorkoutTitle(title),
          );
        },
      ),
    );
  }
}

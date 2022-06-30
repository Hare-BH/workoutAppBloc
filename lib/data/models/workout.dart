// ignore_for_file: hash_and_equals
import 'package:equatable/equatable.dart';

import 'exercise.dart';

class Workout extends Equatable {
  final String id;
  final String title;
  final List<Exercise> exerciseList;
  final String category;

  const Workout({
    required this.id,
    required this.title,
    required this.category,
    required this.exerciseList,
  });

  static Workout fromSnapshot({
    required String id,
    required String title,
    required String category,
    required List<dynamic> exerciseList,
  }) {
    List<Exercise> exercises = [];
    for (var x in exerciseList) {
      final String title = x['exercise_name'];
      final int sets = x['sets'];
      final int reps = x['reps'];
      final int rest = x['rest'];
      exercises.add(Exercise(
        title: title,
        sets: sets,
        reps: reps,
        rest: rest,
      ));
    }
    return Workout(
      id: id,
      title: title,
      category: category,
      exerciseList: exercises,
    );
  }

  @override
  int get hashCode =>
      title.hashCode ^ category.hashCode ^ exerciseList.hashCode;

  @override
  List<Object?> get props => [title, exerciseList, category];
}

part of 'workout_bloc.dart';

@immutable
abstract class WorkoutEvent {}

class LoadWorkoutList extends WorkoutEvent {
  LoadWorkoutList();
}

class LoadSharedWorkoutList extends WorkoutEvent {
  LoadSharedWorkoutList();
}

class AddWorkout extends WorkoutEvent {
  AddWorkout();
}

class UpdateWorkout extends WorkoutEvent {
  UpdateWorkout();
}

class DeleteWorkout extends WorkoutEvent {
  final String id;
  DeleteWorkout(this.id);
}

class AddExerciseToList extends WorkoutEvent {
  final Exercise exercise;
  AddExerciseToList(this.exercise);
}

class DeleteExerciseFromList extends WorkoutEvent {
  final Exercise exercise;
  DeleteExerciseFromList(this.exercise);
}

class SetWorkoutTitle extends WorkoutEvent {
  final String title;
  SetWorkoutTitle(this.title);
}

class SetCategory extends WorkoutEvent {
  final String category;
  SetCategory(this.category);
}

class SetExerciseList extends WorkoutEvent {
  final List<Exercise> exerciseList;
  SetExerciseList(this.exerciseList);
}

class SetWorkout extends WorkoutEvent {
  final Workout workout;
  SetWorkout(this.workout);
}

class ResetWorkoutFields extends WorkoutEvent {
  ResetWorkoutFields();
}

class SortByCategory extends WorkoutEvent {
  final int index;
  SortByCategory(this.index);
}

class ShareWorkout extends WorkoutEvent {
  final String username;
  ShareWorkout(this.username);
}

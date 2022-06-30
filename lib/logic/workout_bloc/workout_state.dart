part of 'workout_bloc.dart';

@immutable
abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object?> get props => [];
}

class WorkoutLoading extends WorkoutState {
  const WorkoutLoading();
}

class WorkoutListLoaded extends WorkoutState {
  final List<Workout> workoutList;
  final List<Category> categoryList;

  const WorkoutListLoaded({
    required this.workoutList,
    required this.categoryList,
  });

  @override
  List<Object?> get props => [workoutList, categoryList];
}

class WorkoutLoaded extends WorkoutState {
  final String id;
  final String title;
  final String category;
  final List<Exercise> exerciseList;
  const WorkoutLoaded({
    required this.title,
    required this.category,
    required this.exerciseList,
    required this.id,
  });

  @override
  List<Object?> get props => [title, category, exerciseList, id];
}

class WorkoutDeleted extends WorkoutState {
  final String message = 'Workout deleted';
  const WorkoutDeleted();
}

class NoWorkouts extends WorkoutState {
  const NoWorkouts();
}

class WorkoutShared extends WorkoutState {
  final String message = 'Workout sent!';
  const WorkoutShared();
}

class ExerciseListLoaded extends WorkoutState {
  final List<Exercise> exerciseList;
  const ExerciseListLoaded(this.exerciseList);
}

class WorkoutError extends WorkoutState {
  final String errorMessage;
  const WorkoutError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

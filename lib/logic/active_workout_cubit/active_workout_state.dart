part of 'active_workout_cubit.dart';

abstract class ActiveWorkoutState extends Equatable {
  const ActiveWorkoutState();

  @override
  List<Object> get props => [];
}

class ActiveWorkoutLoading extends ActiveWorkoutState {}

class ActiveWorkoutLoaded extends ActiveWorkoutState {
  final int index;
  final bool isDone;
  final String title;
  final String category;
  final List<Exercise> exerciseList;
  const ActiveWorkoutLoaded(
    this.title,
    this.category,
    this.exerciseList,
    this.isDone,
    this.index,
  );

  @override
  List<Object> get props => [title, category, exerciseList, isDone, index];
}

class ActiveWorkoutDone extends ActiveWorkoutState {
  const ActiveWorkoutDone();
}

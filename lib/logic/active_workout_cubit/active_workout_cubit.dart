import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';

import '../../data/models/exercise.dart';
import '../../data/models/workout.dart';

part 'active_workout_state.dart';

class ActiveWorkoutCubit extends Cubit<ActiveWorkoutState> {
  late Workout _workout;
  late int exerciseListLength;
  int activeExerciseIndex = 0;
  final WorkoutBloc workoutBloc;
  late StreamSubscription workoutBlocStreamSub;

  ActiveWorkoutCubit({required this.workoutBloc})
      : super(ActiveWorkoutLoading()) {
    loadActiveWorkout();
  }

  void loadActiveWorkout() {
    workoutBlocStreamSub = workoutBloc.stream.listen((workoutBlocState) {
      if (workoutBlocState is WorkoutLoaded) {
        _workout = Workout(
          id: workoutBlocState.id,
          title: workoutBlocState.title,
          category: workoutBlocState.category,
          exerciseList: workoutBlocState.exerciseList,
        );
        exerciseListLength = workoutBlocState.exerciseList.length;
        emit(ActiveWorkoutLoaded(
          workoutBlocState.title,
          workoutBlocState.category,
          workoutBlocState.exerciseList,
          false,
          activeExerciseIndex,
        ));
      }
    });
  }

  void incrementExerciseIndex() {
    activeExerciseIndex++;
    emit(
      ActiveWorkoutLoaded(
        _workout.title,
        _workout.category,
        _workout.exerciseList,
        isWorkoutDone(),
        activeExerciseIndex,
      ),
    );
  }

  void decrementExerciseIndex() {
    activeExerciseIndex--;
    if (activeExerciseIndex < 0) {
      activeExerciseIndex = 0;
    }
    emit(
      ActiveWorkoutLoaded(
        _workout.title,
        _workout.category,
        _workout.exerciseList,
        isWorkoutDone(),
        activeExerciseIndex,
      ),
    );
  }

  bool isWorkoutDone() {
    if (activeExerciseIndex == exerciseListLength) return true;
    return false;
  }

  void resetFields() {
    activeExerciseIndex = 0;
    emit(
      ActiveWorkoutLoaded(
        _workout.title,
        _workout.category,
        _workout.exerciseList,
        false,
        activeExerciseIndex,
      ),
    );
  }

  @override
  Future<void> close() {
    workoutBlocStreamSub.cancel();
    return super.close();
  }

  // @override
  // void onChange(Change<ActiveWorkoutState> change) {
  //   print(activeExerciseIndex);
  //   super.onChange(change);
  // }
}

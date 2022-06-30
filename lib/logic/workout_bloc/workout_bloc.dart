import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:workouts_app_bloc/data/models/workout.dart';
import 'package:workouts_app_bloc/database/db.dart';

import '../../data/models/category.dart';
import '../../data/models/exercise.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository _db;

  String _id = '';
  List<Workout> _workoutList = [];
  List<Exercise> _exerciseList = [];
  List<Category> _categoryList = [
    Category(title: 'All', isPressed: true),
    Category(title: 'Arms'),
    Category(title: 'Abs'),
    Category(title: 'Chest'),
    Category(title: 'Back'),
    Category(title: 'Shoulders'),
    Category(title: 'Legs'),
  ];
  String _title = '';
  String _activeCategory = '';

  WorkoutBloc({required WorkoutRepository db})
      : _db = db,
        super(const WorkoutLoading()) {
    on<LoadWorkoutList>(
      (event, emit) async {
        emit(const WorkoutLoading());
        final workouts = await _db.loadWorkouts();

        workouts.fold(
          (exception) => emit(
            WorkoutError(
              exception.toString(),
            ),
          ),
          (workoutList) {
            if (workoutList.isEmpty) {
              emit(const NoWorkouts());
            } else {
              _workoutList = workoutList;
              emit(WorkoutListLoaded(
                workoutList: workoutList,
                categoryList: _categoryList,
              ));
            }
          },
        );
      },
    );

    on<AddWorkout>((event, emit) async {
      final Workout workout = Workout(
        id: '',
        title: _title,
        category: _activeCategory,
        exerciseList: _exerciseList,
      );
      await _db.addWorkout(workout);
    });

    on<UpdateWorkout>((event, emit) async {
      final Workout workout = Workout(
        id: _id,
        title: _title,
        category: _activeCategory,
        exerciseList: _exerciseList,
      );
      await _db.updateWorkout(workout);
    });

    on<DeleteWorkout>(
      (event, emit) {
        _db.deleteWorkout(event.id);
        emit(const WorkoutDeleted());
        add(LoadWorkoutList());
      },
    );

    on<AddExerciseToList>((event, emit) {
      emit(const WorkoutLoading());
      _exerciseList.add(event.exercise);
      emit(setWorkoutLoaded());
    });

    on<DeleteExerciseFromList>((event, emit) {
      emit(const WorkoutLoading());
      _exerciseList.remove(event.exercise);
      emit(setWorkoutLoaded());
    });

    on<SetWorkoutTitle>((event, emit) {
      _title = event.title;
    });

    on<SetCategory>((event, emit) {
      _activeCategory = event.category;
    });

    on<SetExerciseList>((event, emit) {
      _exerciseList = event.exerciseList;
    });

    on<SetWorkout>((event, emit) {
      emit(const WorkoutLoading());
      _id = event.workout.id;
      _title = event.workout.title;
      _activeCategory = event.workout.category;
      _exerciseList = event.workout.exerciseList;
      emit(setWorkoutLoaded());
    });

    on<ResetWorkoutFields>(
      (event, emit) {
        _id = '';
        _title = '';
        _activeCategory = 'All';
        _exerciseList = [];
        _categoryList = [
          Category(title: 'All', isPressed: true),
          Category(title: 'Arms'),
          Category(title: 'Abs'),
          Category(title: 'Chest'),
          Category(title: 'Back'),
          Category(title: 'Shoulders'),
          Category(title: 'Legs'),
        ];
      },
    );

    on<SortByCategory>((event, emit) {
      emit(const WorkoutLoading());
      for (var i = 0; i < 6; i++) {
        if (i == event.index) {
          _categoryList[i].pressed();
        } else {
          _categoryList[i].notPressed();
        }
      }
      if (event.index == 0) {
        emit(WorkoutListLoaded(
          workoutList: _workoutList,
          categoryList: _categoryList,
        ));
      } else {
        final String selectedCategory = _categoryList[event.index].title;
        List<Workout> workoutList = [];
        for (var workout in _workoutList) {
          if (workout.category == selectedCategory) {
            workoutList.add(workout);
          }
        }
        emit(WorkoutListLoaded(
          workoutList: workoutList,
          categoryList: _categoryList,
        ));
      }
    });

    on<ShareWorkout>(
      (event, emit) async {
        final workout = Workout(
          id: '',
          title: _title,
          category: _activeCategory,
          exerciseList: _exerciseList,
        );
        await db.shareWorkout(
          workout: workout,
          username: event.username,
        );
        emit(const WorkoutShared());
        emit(setWorkoutLoaded());
      },
    );

    on<LoadSharedWorkoutList>(
      (event, emit) async {
        emit(const WorkoutLoading());
        final workouts = await _db.loadShareWorkouts();

        workouts.fold(
          (exception) => emit(
            WorkoutError(
              exception.toString(),
            ),
          ),
          (workoutList) {
            if (workoutList.isEmpty) {
              emit(const NoWorkouts());
            } else {
              _workoutList = workoutList;
              emit(WorkoutListLoaded(
                workoutList: workoutList,
                categoryList: _categoryList,
              ));
            }
          },
        );
      },
    );
  }

  WorkoutLoaded setWorkoutLoaded() {
    return WorkoutLoaded(
      id: _id,
      title: _title,
      exerciseList: _exerciseList,
      category: _activeCategory,
    );
  }
}

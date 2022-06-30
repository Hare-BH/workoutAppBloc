import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:workouts_app_bloc/database/authentication.dart';
import '../data/models/workout.dart';

class WorkoutRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  WorkoutRepository();

  Future<Either<Exception, List<Workout>>> loadWorkouts() async {
    try {
      List<Workout> workouts = [];
      final col = await FirebaseFirestore.instance
          .collection('users')
          .doc(Authentication.uid)
          .collection('workouts')
          .get();
      for (var element in col.docs) {
        final data = element.data();
        workouts.add(
          Workout.fromSnapshot(
            id: element.id,
            title: data['title'],
            category: data['category'],
            exerciseList: data['exerciseList'],
          ),
        );
      }
      return right(workouts);
    } on Exception catch (e) {
      return left(e);
    }
  }

  Future<void> addWorkout(Workout workout) async {
    var dataArray = [];
    transformExerciseToMap(workout, dataArray);
    _db
        .collection('users')
        .doc(Authentication.uid)
        .collection('workouts')
        .doc()
        .set(
      {
        'title': workout.title,
        'category': workout.category,
        'exerciseList': dataArray,
      },
    );
  }

  Future<void> updateWorkout(Workout workout) async {
    var dataArray = [];
    transformExerciseToMap(workout, dataArray);
    _db
        .collection('users')
        .doc(Authentication.uid)
        .collection('workouts')
        .doc(workout.id)
        .set(
      {
        'title': workout.title,
        'category': workout.category,
        'exerciseList': dataArray,
      },
    );
  }

  void deleteWorkout(String id) {
    _db
        .collection('users')
        .doc(Authentication.uid)
        .collection('workouts')
        .doc(id)
        .delete();
  }

  Future<void> shareWorkout({
    required Workout workout,
    required String username,
  }) async {
    var dataArray = [];
    transformExerciseToMap(workout, dataArray);
    _db
        .collection('shared_workouts')
        .doc(username)
        .collection('workouts')
        .doc()
        .set(
      {
        'title': workout.title,
        'category': workout.category,
        'exerciseList': dataArray,
      },
    );
  }

  Future<Either<Exception, List<Workout>>> loadShareWorkouts() async {
    try {
      List<Workout> workouts = [];
      final col = await FirebaseFirestore.instance
          .collection('shared_workouts')
          .doc(Authentication.username)
          .collection('workouts')
          .get();
      for (var element in col.docs) {
        final data = element.data();
        workouts.add(
          Workout.fromSnapshot(
            id: element.id,
            title: data['title'],
            category: data['category'],
            exerciseList: data['exerciseList'],
          ),
        );
      }
      return right(workouts);
    } on Exception catch (e) {
      return left(e);
    }
  }

  void transformExerciseToMap(Workout workout, List<dynamic> dataArray) {
    for (var exercise in workout.exerciseList) {
      Map<String, dynamic> data = {
        'exercise_name': exercise.title,
        'sets': exercise.sets,
        'reps': exercise.reps,
        'rest': exercise.rest,
      };
      dataArray.add(data);
    }
  }
}

// Stream<List<Workout>> workoutsStream() {
  //   return _db
  //       .collection('users')
  //       .doc(uid)
  //       .collection('workouts')
  //       .snapshots()
  //       .map(
  //         (col) => col.docs.map(
  //           (snap) {
  //             return Workout.fromSnapshot(snap);
  //           },
  //         ).toList(),
  //       );
  // }

// ignore_for_file: hash_and_equals

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String title;
  final int sets;
  final int reps;
  final int rest;

  const Exercise({
    required this.title,
    required this.sets,
    required this.reps,
    required this.rest,
  });

  static Exercise fromSnapshot(DocumentSnapshot snap) {
    return Exercise(
      title: snap['title'],
      sets: snap['sets'],
      reps: snap['reps'],
      rest: snap['rest'],
    );
  }

  @override
  int get hashCode =>
      title.hashCode ^ sets.hashCode ^ reps.hashCode ^ rest.hashCode;

  @override
  List<Object?> get props => [title, sets, reps, rest];
}

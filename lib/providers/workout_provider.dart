import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_provider.g.dart';

@riverpod
class WorkoutStatus extends _$WorkoutStatus {
  @override
  bool build() {
    return false;
  }

  void endWorkout() {
    state = false;
  }

  void startWorkout() {
    state = true;
  }
}

@riverpod
class ExerciseStatus extends _$ExerciseStatus {
  @override
  bool build() {
    return false;
  }

  void startExercise() {
    state = true;
  }

  void endExercise() {
    state = !state;
  }
}

@Riverpod(keepAlive: true)
class CurrentExercise extends _$CurrentExercise {
  @override
  String build() {
    return "";
  }

  void setCurrentExercise(String id) {
    state = id;
  }

  void clearCurrentExercise() {
    state = "";
  }
}

class ExerciseSet {
  final String _weight;
  final String _reps;
  final String _id;

  ExerciseSet(String weight, String reps, String id)
      : _weight = weight,
        _reps = reps,
        _id = id;

  String get weight => _weight;
  String get reps => _reps;
  String get id => _id;
}

@riverpod
class SetData extends _$SetData {
  @override
  List<ExerciseSet> build() {
    return [];
  }

  void addSet(String weight, String reps, String id) {
    state = [...state, ExerciseSet(weight, reps, id)];
  }

  void removeSet(String id) {
    var result = [...state];
    result.removeWhere((set) => set.id == id);
    state = [...result];
  }

  void clearSets() {
    state = [];
  }
}

class Exercise {
  final String _name;
  final List<ExerciseSet> _sets;
  final String _id;

  Exercise(String name, List<ExerciseSet> sets, String id)
      : _name = name,
        _sets = sets,
        _id = id;

  String get name => _name;
  List<ExerciseSet> get sets => _sets;
  String get id => _id;

  addSets(List<ExerciseSet> sets) {
    _sets.addAll(sets);
  }

  addSet(ExerciseSet set) {
    _sets.add(set);
  }
}

@riverpod
class ExerciseData extends _$ExerciseData {
  @override
  List<Exercise> build() {
    return [];
  }

  void addExercise(String name, List<ExerciseSet> sets, String id) {
    state = [Exercise(name, sets, id), ...state];
  }

  void addSet(ExerciseSet set, String id) {
    log("Add set");
    var exercise = state.where((ex) => ex.id == id).firstOrNull;
    if (exercise != null) {
      log("Adding set");
      exercise.addSet(set);
      state = [exercise, ...state.where((ex) => ex.id != id)];
    }
  }

  void addSets(List<ExerciseSet> sets, String id) {
    log("Add sets");
    var exercise = state.where((ex) => ex.id == id).firstOrNull;
    if (exercise != null) {
      log("Adding sets");
      exercise.addSets(sets);
      state = [exercise, ...state.where((ex) => ex.id != id)];
    }
  }

  void removeExercise(String id) {
    var result = [...state];
    result.removeWhere((exercise) => exercise.id == id);
    state = [...result];
  }

  void clearExercises() {
    state = [];
  }
}

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_app/data/local_database.dart';
import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/models/exercise_set.dart';
import 'package:gym_tracker_app/state/database_state.dart';
import 'package:gym_tracker_app/state/past_workouts_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'current_workout_state.g.dart';

typedef CurrentWorkoutStateData = ({
  int? workoutId,
  DateTime? workoutStartDateTime,
  DateTime? workoutEndDateTime,
  bool isInProgress,
  List<Exercise> exercises,
  Exercise? currentExercise,
});

const CurrentWorkoutStateData initialCurrentWorkoutStateData = (
  workoutId: null,
  workoutStartDateTime: null,
  workoutEndDateTime: null,
  isInProgress: false,
  exercises: [],
  currentExercise: null,
);

@Riverpod(keepAlive: true)
class CurrentWorkoutNotifier extends _$CurrentWorkoutNotifier {
  @override
  CurrentWorkoutStateData build() => initialCurrentWorkoutStateData;

  void _setState({
    int? workoutId,
    DateTime? workoutStartDateTime,
    DateTime? workoutEndDateTime,
    bool? isInProgress,
    List<Exercise>? exercises,
    Exercise? currentExercise,
  }) {
    state = (
      workoutId: workoutId ?? state.workoutId,
      workoutStartDateTime: workoutStartDateTime ?? state.workoutStartDateTime,
      workoutEndDateTime: workoutEndDateTime ?? state.workoutEndDateTime,
      isInProgress: isInProgress ?? state.isInProgress,
      exercises: exercises ?? state.exercises,
      currentExercise: currentExercise ?? state.currentExercise,
    );
  }

  // Provide "true" for the values that should be reset
  void _resetState({
    bool workoutId = false,
    bool workoutStartDateTime = false,
    bool workoutEndDateTime = false,
    bool isInProgress = false,
    bool exercises = false,
    bool currentExercise = false,
  }) {
    state = (
      workoutId: workoutId == true
          ? initialCurrentWorkoutStateData.workoutId
          : state.workoutId,
      workoutStartDateTime: workoutStartDateTime == true
          ? initialCurrentWorkoutStateData.workoutStartDateTime
          : state.workoutStartDateTime,
      workoutEndDateTime: workoutEndDateTime == true
          ? initialCurrentWorkoutStateData.workoutEndDateTime
          : state.workoutEndDateTime,
      isInProgress: isInProgress == true
          ? initialCurrentWorkoutStateData.isInProgress
          : state.isInProgress,
      exercises: exercises == true
          ? initialCurrentWorkoutStateData.exercises
          : state.exercises,
      currentExercise: currentExercise == true
          ? initialCurrentWorkoutStateData.currentExercise
          : state.currentExercise,
    );
  }

  void resetState() => state = initialCurrentWorkoutStateData;

  Future<void> startWorkout() async {
    var database = ref.read(databaseNotifierProvider).database;
    if (database == null) {
      return;
    }

    var startTime = DateTime.now();
    var rowId = await database.into(database.databaseWorkouts).insert(
        DatabaseWorkoutsCompanion.insert(
            startTime: Value(startTime), createdAt: Value(startTime)));

    _setState(
        isInProgress: true, workoutStartDateTime: startTime, workoutId: rowId);
  }

  Future<void> endWorkout() async {
    // TODO: save workout data if it is not empty
    var database = ref.read(databaseNotifierProvider).database;
    if (database == null) {
      return;
    }

    DateTime endTime = DateTime.now();

    await (database.update(database.databaseWorkouts)
          ..where((val) => val.id.equals(state.workoutId!)))
        .write(DatabaseWorkoutsCompanion(endTime: Value(endTime)));

    resetState();

    ref
        .read(pastWorkoutsNotifierProvider.notifier)
        .getWorkoutsFromLocalStorage();
  }

  Future<void> addExerciseToExerciseList(Exercise exercise) async {
    _setState(exercises: [...state.exercises, exercise]);
  }

  Future<void> startExercise(String name) async {
    var database = ref.read(databaseNotifierProvider).database;
    if (database == null) {
      return;
    }
    var startTime = DateTime.now();
    var rowId = await database.into(database.databaseExercises).insert(
        DatabaseExercisesCompanion.insert(
            startTime: Value(startTime),
            workoutId: Value(state.workoutId),
            name: Value(name)));
    _setState(currentExercise: Exercise(name, {}, rowId, startTime));
  }

  Future<void> endExercise() async {
    var database = ref.read(databaseNotifierProvider).database;
    if (database == null) {
      return;
    }

    DateTime endTime = DateTime.now();
    if (state.currentExercise != null &&
        (state.currentExercise?.sets.length ?? 0) > 0) {
      final exercise = state.currentExercise!..setEndTime(endTime);
      _setState(exercises: [...state.exercises, exercise]);
    }

    await (database.update(database.databaseExercises)
          ..where((val) => val.id.equals(state.currentExercise!.id)))
        .write(DatabaseExercisesCompanion(endTime: Value(endTime)));

    _resetState(currentExercise: true);
  }

  Future<void> addSetToCurrentExercise(String reps, String weight) async {
    var parsedReps = int.tryParse(reps);
    var parsedWeight = double.tryParse(weight);
    var exerciseId = state.currentExercise?.id;

    if (parsedReps == null ||
        parsedWeight == null ||
        parsedReps <= 0 ||
        parsedWeight <= 0 ||
        exerciseId == null) {
      return;
    }

    var database = ref.read(databaseNotifierProvider).database;
    if (database == null) {
      return;
    }
    var rowId = await database
        .into(database.databaseExerciseSets)
        .insert(DatabaseExerciseSetsCompanion.insert(
          exerciseId: Value(exerciseId),
          setNumber: Value(state.currentExercise?.sets.length ?? 0),
          reps: Value(parsedReps),
          weight: Value(parsedWeight),
        ));

    _setState(
        currentExercise:
            state.currentExercise?.addSet(ExerciseSet(weight, reps, rowId)));
  }

  Future<void> removeSetFromCurrentExercise(int setId) async {
    _setState(currentExercise: state.currentExercise?.removeSet(setId));
  }
}

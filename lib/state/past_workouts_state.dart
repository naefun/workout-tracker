import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/models/exercise_set.dart';
import 'package:gym_tracker_app/state/database_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'past_workouts_state.g.dart';

typedef PastWorkoutsStateData = ({
  List<Workout> workouts,
});

const PastWorkoutsStateData initialPastWorkoutsStateData = (workouts: [],);

@Riverpod(keepAlive: true)
class PastWorkoutsNotifier extends _$PastWorkoutsNotifier {
  @override
  PastWorkoutsStateData build() => initialPastWorkoutsStateData;

  void _setState({
    List<Workout>? workouts,
  }) {
    state = (workouts: workouts ?? state.workouts,);
  }

  // Provide "true" for the values that should be reset
  void _resetState({
    bool workouts = false,
  }) {
    state = (
      workouts: workouts == true
          ? initialPastWorkoutsStateData.workouts
          : state.workouts,
    );
  }

  void resetState() => state = initialPastWorkoutsStateData;

  getWorkoutsFromLocalStorage() async {
    var database = ref.read(databaseNotifierProvider).database;
    if (database == null) {
      return;
    }

    try {
      // First get all workouts with their exercises and sets using joins
      final results = await database.customSelect('''
        SELECT 
          w.id as workout_id, 
          w.start_time as workout_start, 
          w.end_time as workout_end,
          e.id as exercise_id,
          e.name as exercise_name,
          e.start_time as exercise_start,
          e.end_time as exercise_end,
          s.id as set_id,
          s.weight as set_weight,
          s.reps as set_reps
        FROM database_workouts w
        LEFT JOIN database_exercises e ON e.workout_id = w.id
        LEFT JOIN database_exercise_sets s ON s.exercise_id = e.id
        ORDER BY w.start_time DESC, e.start_time ASC, s.id ASC
        ''').get();

      // Map to store workouts while building them
      final Map<int, Workout> workouts = {};

      // Iterate through results and build workout objects
      for (final row in results) {
        log('row: ${row.read<int>('workout_id')}');
        final workoutId = row.readNullable<int>('workout_id');
        final workoutStart = row.readNullable<DateTime>('workout_start');
        final workoutEnd = row.readNullable<DateTime>('workout_end');

        final exerciseId = row.readNullable<int>('exercise_id');
        final exerciseName = row.readNullable<String>('exercise_name');
        final exerciseStart = row.readNullable<DateTime>('exercise_start');
        final exerciseEnd = row.readNullable<DateTime>('exercise_end');

        final setId = row.readNullable<int>('set_id');
        final setWeight = row.readNullable<String>('set_weight');
        final setReps = row.readNullable<String>('set_reps');

        // if workouts does not contain key
        // create new workout
        // add workout to workouts
        if (workoutId != null) {
          if (!workouts.containsKey(workoutId)) {
            workouts[workoutId] =
                Workout(workoutId, workoutStart, workoutEnd, {});
          }
        } else {
          continue;
        }

        // if workouts[key] exercises does not contain exercise key
        // create new exercise
        // add exercise to workouts[key] exercises
        if (exerciseId != null &&
            exerciseName != null &&
            exerciseStart != null &&
            exerciseEnd != null) {
          if (!workouts[workoutId]!.exercises.containsKey(exerciseId)) {
            Exercise exercise = Exercise(
              exerciseName,
              {},
              exerciseId,
              exerciseStart,
            );

            exercise.setEndTime(exerciseEnd);

            workouts[workoutId]!.addExercise(exercise);
          }
        } else {
          continue;
        }

        if (setId != null && setWeight != null && setReps != null) {
          if (!workouts[workoutId]!
              .exercises[exerciseId]!
              .sets
              .containsKey(setId)) {
            workouts[workoutId]!
                .exercises[exerciseId]!
                .addSet(ExerciseSet(setWeight, setReps, setId));
          }
        } else {
          continue;
        }
      }
      for (var workout in workouts.values) {
        log('--------------------------------');
        log('workout: ${workout.id} ${workout.startTime} ${workout.endTime}');
        for (var exercise in workout.exercises.values) {
          log('exercise: ${exercise.id} ${exercise.name} ${exercise.startTime} ${exercise.endTime}');
          for (var set in exercise.sets.values) {
            log('set: ${set.id} ${set.reps} ${set.weight}');
          }
        }
        log('--------------------------------');
      }
      _setState(workouts: workouts.values.toList());
    } catch (e) {
      log('Error retrieving workouts: $e');
    }
  }
}

class Workout {
  final int _id;
  final DateTime? _startTime;
  final DateTime? _endTime;
  final Map<int, Exercise> _exercises;

  Workout(this._id, this._startTime, this._endTime, this._exercises);

  int get id => _id;
  DateTime? get startTime => _startTime;
  DateTime? get endTime => _endTime;
  Map<int, Exercise> get exercises => _exercises;

  void addExercise(Exercise exercise) {
    if (!_exercises.containsKey(exercise.id)) {
      _exercises[exercise.id] = exercise;
    }
  }

  void addSet(ExerciseSet set, int exerciseId) {
    if (!_exercises.containsKey(exerciseId) ||
        !_exercises[exerciseId]!.sets.containsKey(set.id)) {
      return;
    }
    _exercises[exerciseId]!.addSet(set);
  }
}

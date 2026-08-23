import 'dart:developer';

import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/models/exercise_set.dart';
import 'package:gym_tracker_app/state/past_workouts_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  SupabaseClient get _client => Supabase.instance.client;

  Exercise _cloneExerciseWithSets(
      Exercise exercise, Map<int, ExerciseSet> sets) {
    final updated = Exercise(
      exercise.name,
      sets,
      exercise.id,
      exercise.startTime,
    );
    if (exercise.endTime != null) {
      updated.setEndTime(exercise.endTime!);
    }
    return updated;
  }

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
    final user = _client.auth.currentUser;
    if (user == null) {
      return;
    }

    try {
      final startTime = DateTime.now();
      final row = await _client
          .from('workouts')
          .insert({
            'user_id': user.id,
            'start_time': startTime.toUtc().toIso8601String(),
            'created_at': startTime.toUtc().toIso8601String(),
          })
          .select('id')
          .single();
      final rowId = (row['id'] as num).toInt();

      _setState(
        isInProgress: true,
        workoutStartDateTime: startTime,
        workoutId: rowId,
      );
    } catch (error, stackTrace) {
      log(
        'Failed to start the workout.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> endWorkout() async {
    final user = _client.auth.currentUser;
    final workoutId = state.workoutId;
    if (user == null || workoutId == null) {
      return;
    }

    try {
      final endTime = DateTime.now();

      if (state.exercises.isNotEmpty) {
        await _client
            .from('workouts')
            .update({'end_time': endTime.toUtc().toIso8601String()})
            .eq('id', workoutId)
            .eq('user_id', user.id);
      } else {
        await _client
            .from('workouts')
            .delete()
            .eq('id', workoutId)
            .eq('user_id', user.id);
      }

      resetState();
      await ref.read(pastWorkoutsProvider.notifier).getWorkoutsFromRemote();
    } catch (error, stackTrace) {
      log(
        'Failed to end the workout.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> addExerciseToExerciseList(Exercise exercise) async {
    _setState(exercises: [...state.exercises, exercise]);
  }

  Future<void> startExercise(String name) async {
    final workoutId = state.workoutId;
    if (_client.auth.currentUser == null || workoutId == null) {
      return;
    }

    try {
      final startTime = DateTime.now();
      final row = await _client
          .from('exercises')
          .insert({
            'start_time': startTime.toUtc().toIso8601String(),
            'workout_id': workoutId,
            'name': name,
          })
          .select('id')
          .single();
      final rowId = (row['id'] as num).toInt();

      _setState(currentExercise: Exercise(name, {}, rowId, startTime));
    } catch (error, stackTrace) {
      log(
        'Failed to start the exercise.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> endExercise() async {
    final currentExercise = state.currentExercise;
    if (_client.auth.currentUser == null || currentExercise == null) {
      return;
    }

    try {
      final endTime = DateTime.now();

      if (currentExercise.sets.isNotEmpty) {
        await _client
            .from('exercises')
            .update({'end_time': endTime.toUtc().toIso8601String()}).eq(
                'id', currentExercise.id);
        currentExercise.setEndTime(endTime);
        _setState(exercises: [...state.exercises, currentExercise]);
      } else {
        await _client.from('exercises').delete().eq('id', currentExercise.id);
      }

      _resetState(currentExercise: true);
    } catch (error, stackTrace) {
      log(
        'Failed to end the exercise.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> addSetToCurrentExercise(String reps, String weight) async {
    var parsedReps = int.tryParse(reps);
    var parsedWeight = double.tryParse(weight);
    var exerciseId = state.currentExercise?.id;

    if (parsedReps == null ||
        parsedWeight == null ||
        parsedReps < 0 ||
        parsedWeight < 0 ||
        exerciseId == null) {
      return;
    }

    if (_client.auth.currentUser == null) {
      return;
    }

    try {
      final row = await _client
          .from('exercise_sets')
          .insert({
            'exercise_id': exerciseId,
            'set_number': state.currentExercise?.sets.length ?? 0,
            'reps': parsedReps,
            'weight': parsedWeight,
          })
          .select('id')
          .single();
      final rowId = (row['id'] as num).toInt();

      final currentExercise = state.currentExercise;
      if (currentExercise == null) {
        return;
      }

      final updatedSets = Map<int, ExerciseSet>.from(currentExercise.sets);
      updatedSets[rowId] = ExerciseSet(weight, reps, rowId);

      _setState(
        currentExercise: _cloneExerciseWithSets(currentExercise, updatedSets),
      );
    } catch (error, stackTrace) {
      log(
        'Failed to add the exercise set.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> removeSetFromCurrentExercise(int setId) async {
    final currentExercise = state.currentExercise;
    if (_client.auth.currentUser == null ||
        !state.isInProgress ||
        currentExercise == null ||
        currentExercise.endTime != null ||
        !currentExercise.sets.containsKey(setId)) {
      return;
    }

    try {
      final deletedRows = await _client
          .from('exercise_sets')
          .delete()
          .eq('id', setId)
          .eq('exercise_id', currentExercise.id)
          .select('id');

      if (deletedRows.isEmpty) {
        return;
      }

      final latestExercise = state.currentExercise;
      if (!state.isInProgress ||
          latestExercise == null ||
          latestExercise.id != currentExercise.id ||
          latestExercise.endTime != null) {
        return;
      }

      final updatedSets = Map<int, ExerciseSet>.from(latestExercise.sets)
        ..remove(setId);

      _setState(
        currentExercise: _cloneExerciseWithSets(latestExercise, updatedSets),
      );

      var setNumber = 0;
      for (final remainingSetId in updatedSets.keys) {
        await _client
            .from('exercise_sets')
            .update({'set_number': setNumber})
            .eq('id', remainingSetId)
            .eq('exercise_id', currentExercise.id);
        setNumber++;
      }
    } catch (error, stackTrace) {
      log(
        'Failed to remove the exercise set.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

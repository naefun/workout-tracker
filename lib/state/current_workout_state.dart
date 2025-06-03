import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/models/exercise_set.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'current_workout_state.g.dart';

typedef CurrentWorkoutStateData = ({
  String? workoutId,
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
    String? workoutId,
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
    _setState(isInProgress: true, workoutStartDateTime: DateTime.now());
  }

  Future<void> endWorkout() async {
    // TODO: save workout data if it is not empty
    resetState();
  }

  Future<void> addExerciseToExerciseList(Exercise exercise) async {
    _setState(exercises: [...state.exercises, exercise]);
  }

  Future<void> startExercise(String name) async {
    String id = Uuid().v4();
    _setState(currentExercise: Exercise(name, [], id, DateTime.now()));
  }

  Future<void> endExercise() async {
    if (state.currentExercise != null &&
        (state.currentExercise?.sets.length ?? 0) > 0) {
      final exercise = state.currentExercise!..setEndTime(DateTime.now());
      _setState(exercises: [...state.exercises, exercise]);
    }
    _resetState(currentExercise: true);
  }

  Future<void> addSetToCurrentExercise(ExerciseSet set) async {
    _setState(currentExercise: state.currentExercise?.addSet(set));
  }

  Future<void> removeSetFromCurrentExercise(String setId) async {
    _setState(currentExercise: state.currentExercise?.removeSet(setId));
  }
}

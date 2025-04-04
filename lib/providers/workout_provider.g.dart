// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workoutStatusHash() => r'1357884a5114049e54515bc25c16d92f26d04c31';

/// See also [WorkoutStatus].
@ProviderFor(WorkoutStatus)
final workoutStatusProvider =
    AutoDisposeNotifierProvider<WorkoutStatus, bool>.internal(
  WorkoutStatus.new,
  name: r'workoutStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$workoutStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WorkoutStatus = AutoDisposeNotifier<bool>;
String _$exerciseStatusHash() => r'd1ff197c7f6990f1d74c5f3389d465cd9cdd6bff';

/// See also [ExerciseStatus].
@ProviderFor(ExerciseStatus)
final exerciseStatusProvider =
    AutoDisposeNotifierProvider<ExerciseStatus, bool>.internal(
  ExerciseStatus.new,
  name: r'exerciseStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exerciseStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExerciseStatus = AutoDisposeNotifier<bool>;
String _$currentExerciseHash() => r'08cdb791fcef77f25c8193fa242a6f0136070d1c';

/// See also [CurrentExercise].
@ProviderFor(CurrentExercise)
final currentExerciseProvider =
    NotifierProvider<CurrentExercise, String>.internal(
  CurrentExercise.new,
  name: r'currentExerciseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentExerciseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentExercise = Notifier<String>;
String _$setDataHash() => r'df513da9fdfc47518604f2ae49f85a712d4b73dd';

/// See also [SetData].
@ProviderFor(SetData)
final setDataProvider =
    AutoDisposeNotifierProvider<SetData, List<ExerciseSet>>.internal(
  SetData.new,
  name: r'setDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$setDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SetData = AutoDisposeNotifier<List<ExerciseSet>>;
String _$exerciseDataHash() => r'17924b18c7bd744d66d07b84353025869ed9ebbb';

/// See also [ExerciseData].
@ProviderFor(ExerciseData)
final exerciseDataProvider =
    AutoDisposeNotifierProvider<ExerciseData, List<Exercise>>.internal(
  ExerciseData.new,
  name: r'exerciseDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$exerciseDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExerciseData = AutoDisposeNotifier<List<Exercise>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

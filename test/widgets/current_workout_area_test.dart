import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/models/exercise_set.dart';
import 'package:gym_tracker_app/screens/home/widgets/home_screen/current_workout_area.dart';
import 'package:gym_tracker_app/state/current_workout_state.dart';

void main() {
  testWidgets('overlays a remove menu without changing set card dimensions',
      (tester) async {
    var removed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CurrentExerciseSetCard(
              weight: '80',
              reps: '10',
              onRemove: () => removed = true,
            ),
          ),
        ),
      ),
    );

    expect(
      tester.getSize(find.byType(CurrentExerciseSetCard)),
      const Size(121, 167),
    );
    expect(find.text('80'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.byIcon(Icons.more_vert), findsOneWidget);
    expect(
      tester.getCenter(find.text('80')).dx,
      tester.getCenter(find.byType(CurrentExerciseSetCard)).dx,
    );
    expect(
      tester.getCenter(find.text('10')).dx,
      tester.getCenter(find.byType(CurrentExerciseSetCard)).dx,
    );

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    expect(find.text('Remove set'), findsOneWidget);

    await tester.tap(find.text('Remove set'));
    await tester.pumpAndSettle();

    expect(removed, isTrue);
  });

  testWidgets('does not show set menus after an exercise is completed',
      (tester) async {
    final startTime = DateTime(2026, 8, 23, 9);
    final completedExercise = Exercise(
      'Squat',
      {1: ExerciseSet('80', '10', 1)},
      1,
      startTime,
    )..setEndTime(startTime.add(const Duration(minutes: 10)));

    final completedExerciseState = (
      workoutId: 1,
      workoutStartDateTime: startTime,
      workoutEndDateTime: null,
      isInProgress: true,
      exercises: [completedExercise],
      currentExercise: null,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentWorkoutProvider.overrideWithValue(completedExerciseState),
        ],
        child: const MaterialApp(
          home: Scaffold(body: CurrentWorkoutArea()),
        ),
      ),
    );

    expect(find.byIcon(Icons.more_vert), findsNothing);
  });
}

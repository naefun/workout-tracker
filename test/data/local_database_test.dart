import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_tracker_app/data/local_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('deleteAllUserData removes workouts, exercises, and sets', () async {
    final workoutId = await database.into(database.databaseWorkouts).insert(
          DatabaseWorkoutsCompanion.insert(
            createdAt: Value(DateTime(2026)),
          ),
        );
    final exerciseId = await database.into(database.databaseExercises).insert(
          DatabaseExercisesCompanion.insert(
            name: const Value('Squat'),
            workoutId: Value(workoutId),
          ),
        );
    await database.into(database.databaseExerciseSets).insert(
          DatabaseExerciseSetsCompanion.insert(
            exerciseId: Value(exerciseId),
            reps: const Value(5),
            weight: const Value(100),
          ),
        );

    await database.deleteAllUserData();

    expect(await database.select(database.databaseExerciseSets).get(), isEmpty);
    expect(await database.select(database.databaseExercises).get(), isEmpty);
    expect(await database.select(database.databaseWorkouts).get(), isEmpty);
  });
}

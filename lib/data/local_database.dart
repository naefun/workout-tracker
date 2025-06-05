import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:gym_tracker_app/data/local_database.steps.dart';
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

class DatabaseWorkouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class DatabaseExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  IntColumn get sets => integer().nullable()();
  IntColumn get reps => integer().nullable()();
  IntColumn get weight => integer().nullable()();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get workoutId => integer().nullable()();
  IntColumn get exerciseNumber => integer().nullable()();
}

class DatabaseExerciseSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer().nullable()();
  IntColumn get setNumber => integer().nullable()();
  IntColumn get reps => integer().nullable()();
  RealColumn get weight => real().nullable()();
}

@DriftDatabase(
    tables: [DatabaseWorkouts, DatabaseExercises, DatabaseExerciseSets])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.createTable(schema.databaseExerciseSets);
          await m.createTable(schema.databaseExercises);
          await m.createTable(schema.databaseWorkouts);
        },
      ),
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'gym_tracker_app',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}

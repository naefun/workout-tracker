import 'package:gym_tracker_app/data/local_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_state.g.dart';

typedef DatabaseStateData = ({
  AppDatabase? database,
});

const DatabaseStateData initialDatabaseStateData = (database: null,);

@Riverpod(keepAlive: true)
class DatabaseNotifier extends _$DatabaseNotifier {
  @override
  DatabaseStateData build() => initialDatabaseStateData;

  void _setState({
    AppDatabase? database,
  }) {
    state = (database: database ?? state.database,);
  }

  // Provide "true" for the values that should be reset
  void _resetState({
    bool database = false,
  }) {
    state = (database: database == true ? null : state.database,);
  }

  void resetState() => state = initialDatabaseStateData;

  void initDatabase() {
    _setState(database: AppDatabase());
  }
}

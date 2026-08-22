import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<void> deleteLegacyWorkoutDatabase() async {
  try {
    final directory = await getApplicationSupportDirectory();
    final databasePath =
        '${directory.path}${Platform.pathSeparator}gym_tracker_app.sqlite';

    for (final suffix in ['', '-shm', '-wal']) {
      final file = File('$databasePath$suffix');
      if (await file.exists()) {
        await file.delete();
      }
    }
  } catch (error, stackTrace) {
    log(
      'Failed to delete the legacy workout database.',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

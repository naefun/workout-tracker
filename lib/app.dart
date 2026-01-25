import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/main_bottom_navigation.dart';
import 'package:gym_tracker_app/state/database_state.dart';
import 'package:gym_tracker_app/state/past_workouts_state.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(databaseProvider.notifier).initDatabase();

      ref
          .read(pastWorkoutsProvider.notifier)
          .getWorkoutsFromLocalStorage();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainBottomNavigation(),
    );
  }
}

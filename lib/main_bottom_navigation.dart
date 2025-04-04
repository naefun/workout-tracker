import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/home/home_screen.dart';
import 'package:gym_tracker_app/providers/workout_provider.dart';

class MainBottomNavigation extends ConsumerStatefulWidget {
  const MainBottomNavigation({super.key});

  @override
  ConsumerState<MainBottomNavigation> createState() =>
      _MainBottomNavigationState();
}

class _MainBottomNavigationState extends ConsumerState<MainBottomNavigation> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool workoutStatus = ref.watch(workoutStatusProvider);
    bool exerciseStatus = ref.watch(exerciseStatusProvider);
    List<ExerciseSet> sets = ref.watch(setDataProvider);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => {
          setState(() {
            _currentPageIndex = value;
          })
        },
        selectedIndex: _currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Badge(child: Icon(Icons.notifications_sharp)),
            icon: Badge(child: Icon(Icons.notifications_outlined)),
            label: 'Notifications',
          ),
          NavigationDestination(
            selectedIcon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_outline),
            ),
            label: 'Messages',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(),
        child: <Widget>[
          const HomeScreen(),
          const Text("Page 2"),
          const Text("Page 3"),
        ][_currentPageIndex],
      ),
    );
  }
}

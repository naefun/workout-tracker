import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/home/home_screen_v2.dart';

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
    return Scaffold(
      backgroundColor: Color(0xff202730),
      bottomNavigationBar: NavigationBar(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (states) => TextStyle(
            color: states.contains(WidgetState.selected)
                ? Color(0xffB6E3FF)
                : Color(0xffB6E3FF),
          ),
        ),
        backgroundColor: Color(0xff232F3E),
        indicatorColor: Color(0xffB6E3FF),
        onDestinationSelected: (value) => {
          setState(() {
            _currentPageIndex = value;
          })
        },
        selectedIndex: _currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(
              Icons.home_outlined,
              color: Color(0xffB6E3FF),
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Badge(child: Icon(Icons.notifications_sharp)),
            icon: Badge(
                child: Icon(
              Icons.notifications_outlined,
              color: Color(0xffB6E3FF),
            )),
            label: 'Notifications',
          ),
          NavigationDestination(
            selectedIcon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            icon: Badge(
              label: Text('2'),
              child: Icon(
                Icons.messenger_outline,
                color: Color(0xffB6E3FF),
              ),
            ),
            label: 'Messages',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(),
        child: <Widget>[
          const HomeScreenV2(),
          const Text("Page 2"),
          const Text("Page 3"),
        ][_currentPageIndex],
      ),
    );
  }
}

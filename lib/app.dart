import 'package:flutter/material.dart';
import 'package:gym_tracker_app/main_bottom_navigation.dart';
import 'package:gym_tracker_app/widgets/authentication_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AuthenticatorController(
        child: MainBottomNavigation(),
      ),
    );
  }
}

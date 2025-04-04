import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/app.dart';

void main() {
  runApp(ProviderScope(child: const App()));
}

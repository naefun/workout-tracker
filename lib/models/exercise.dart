import 'package:gym_tracker_app/models/exercise_set.dart';

class Exercise {
  final String _name;
  final List<ExerciseSet> _sets;
  final String _id;

  Exercise(String name, List<ExerciseSet> sets, String id)
      : _name = name,
        _sets = sets,
        _id = id;

  String get name => _name;
  List<ExerciseSet> get sets => _sets;
  String get id => _id;

  Exercise addSets(List<ExerciseSet> sets) {
    _sets.addAll(sets);
    return this;
  }

  Exercise addSet(ExerciseSet set) {
    _sets.add(set);
    return this;
  }

  Exercise removeSet(String setId) {
    _sets.removeWhere((set) => set.id == setId);
    return this;
  }
}

import 'package:gym_tracker_app/models/exercise_set.dart';

class Exercise {
  final String _name;
  final List<ExerciseSet> _sets;
  final String _id;
  final DateTime _startTime;
  DateTime? _endTime;

  Exercise(
    String name,
    List<ExerciseSet> sets,
    String id,
    DateTime startTime,
  )   : _name = name,
        _sets = sets,
        _id = id,
        _startTime = startTime;

  String get name => _name;
  List<ExerciseSet> get sets => _sets;
  String get id => _id;
  DateTime get startTime => _startTime;
  DateTime? get endTime => _endTime;
  Exercise addSets(List<ExerciseSet> sets) {
    _sets.addAll(sets);
    return this;
  }

  Exercise addSet(ExerciseSet set) {
    _sets.add(set);
    return this;
  }

  Exercise setEndTime(DateTime endTime) {
    _endTime = endTime;
    return this;
  }

  Exercise removeSet(String setId) {
    _sets.removeWhere((set) => set.id == setId);
    return this;
  }
}

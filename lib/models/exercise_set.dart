class ExerciseSet {
  final String _weight;
  final String _reps;
  final String _id;

  ExerciseSet(String weight, String reps, String id)
      : _weight = weight,
        _reps = reps,
        _id = id;

  String get weight => _weight;
  String get reps => _reps;
  String get id => _id;
}

class ExerciseSet {
  final String _weight;
  final String _reps;
  final int _id;

  ExerciseSet(String weight, String reps, int id)
      : _weight = weight,
        _reps = reps,
        _id = id;

  String get weight => _weight;
  String get reps => _reps;
  int get id => _id;
}

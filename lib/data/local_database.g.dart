// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $DatabaseWorkoutsTable extends DatabaseWorkouts
    with TableInfo<$DatabaseWorkoutsTable, DatabaseWorkout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DatabaseWorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, startTime, endTime, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'database_workouts';
  @override
  VerificationContext validateIntegrity(Insertable<DatabaseWorkout> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatabaseWorkout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatabaseWorkout(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $DatabaseWorkoutsTable createAlias(String alias) {
    return $DatabaseWorkoutsTable(attachedDatabase, alias);
  }
}

class DatabaseWorkout extends DataClass implements Insertable<DatabaseWorkout> {
  final int id;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? createdAt;
  const DatabaseWorkout(
      {required this.id, this.startTime, this.endTime, this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  DatabaseWorkoutsCompanion toCompanion(bool nullToAbsent) {
    return DatabaseWorkoutsCompanion(
      id: Value(id),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory DatabaseWorkout.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatabaseWorkout(
      id: serializer.fromJson<int>(json['id']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  DatabaseWorkout copyWith(
          {int? id,
          Value<DateTime?> startTime = const Value.absent(),
          Value<DateTime?> endTime = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent()}) =>
      DatabaseWorkout(
        id: id ?? this.id,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  DatabaseWorkout copyWithCompanion(DatabaseWorkoutsCompanion data) {
    return DatabaseWorkout(
      id: data.id.present ? data.id.value : this.id,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseWorkout(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startTime, endTime, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DatabaseWorkout &&
          other.id == this.id &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.createdAt == this.createdAt);
}

class DatabaseWorkoutsCompanion extends UpdateCompanion<DatabaseWorkout> {
  final Value<int> id;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<DateTime?> createdAt;
  const DatabaseWorkoutsCompanion({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DatabaseWorkoutsCompanion.insert({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<DatabaseWorkout> custom({
    Expression<int>? id,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DatabaseWorkoutsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime?>? startTime,
      Value<DateTime?>? endTime,
      Value<DateTime?>? createdAt}) {
    return DatabaseWorkoutsCompanion(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseWorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DatabaseExercisesTable extends DatabaseExercises
    with TableInfo<$DatabaseExercisesTable, DatabaseExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DatabaseExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
      'sets', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _workoutIdMeta =
      const VerificationMeta('workoutId');
  @override
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
      'workout_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _exerciseNumberMeta =
      const VerificationMeta('exerciseNumber');
  @override
  late final GeneratedColumn<int> exerciseNumber = GeneratedColumn<int>(
      'exercise_number', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        sets,
        reps,
        weight,
        startTime,
        endTime,
        workoutId,
        exerciseNumber
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'database_exercises';
  @override
  VerificationContext validateIntegrity(Insertable<DatabaseExercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('sets')) {
      context.handle(
          _setsMeta, sets.isAcceptableOrUnknown(data['sets']!, _setsMeta));
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('workout_id')) {
      context.handle(_workoutIdMeta,
          workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta));
    }
    if (data.containsKey('exercise_number')) {
      context.handle(
          _exerciseNumberMeta,
          exerciseNumber.isAcceptableOrUnknown(
              data['exercise_number']!, _exerciseNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatabaseExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatabaseExercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      sets: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sets']),
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight']),
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      workoutId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_id']),
      exerciseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_number']),
    );
  }

  @override
  $DatabaseExercisesTable createAlias(String alias) {
    return $DatabaseExercisesTable(attachedDatabase, alias);
  }
}

class DatabaseExercise extends DataClass
    implements Insertable<DatabaseExercise> {
  final int id;
  final String? name;
  final int? sets;
  final int? reps;
  final int? weight;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? workoutId;
  final int? exerciseNumber;
  const DatabaseExercise(
      {required this.id,
      this.name,
      this.sets,
      this.reps,
      this.weight,
      this.startTime,
      this.endTime,
      this.workoutId,
      this.exerciseNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || sets != null) {
      map['sets'] = Variable<int>(sets);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || workoutId != null) {
      map['workout_id'] = Variable<int>(workoutId);
    }
    if (!nullToAbsent || exerciseNumber != null) {
      map['exercise_number'] = Variable<int>(exerciseNumber);
    }
    return map;
  }

  DatabaseExercisesCompanion toCompanion(bool nullToAbsent) {
    return DatabaseExercisesCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      sets: sets == null && nullToAbsent ? const Value.absent() : Value(sets),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      workoutId: workoutId == null && nullToAbsent
          ? const Value.absent()
          : Value(workoutId),
      exerciseNumber: exerciseNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseNumber),
    );
  }

  factory DatabaseExercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatabaseExercise(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      sets: serializer.fromJson<int?>(json['sets']),
      reps: serializer.fromJson<int?>(json['reps']),
      weight: serializer.fromJson<int?>(json['weight']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      workoutId: serializer.fromJson<int?>(json['workoutId']),
      exerciseNumber: serializer.fromJson<int?>(json['exerciseNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'sets': serializer.toJson<int?>(sets),
      'reps': serializer.toJson<int?>(reps),
      'weight': serializer.toJson<int?>(weight),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'workoutId': serializer.toJson<int?>(workoutId),
      'exerciseNumber': serializer.toJson<int?>(exerciseNumber),
    };
  }

  DatabaseExercise copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<int?> sets = const Value.absent(),
          Value<int?> reps = const Value.absent(),
          Value<int?> weight = const Value.absent(),
          Value<DateTime?> startTime = const Value.absent(),
          Value<DateTime?> endTime = const Value.absent(),
          Value<int?> workoutId = const Value.absent(),
          Value<int?> exerciseNumber = const Value.absent()}) =>
      DatabaseExercise(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        sets: sets.present ? sets.value : this.sets,
        reps: reps.present ? reps.value : this.reps,
        weight: weight.present ? weight.value : this.weight,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        workoutId: workoutId.present ? workoutId.value : this.workoutId,
        exerciseNumber:
            exerciseNumber.present ? exerciseNumber.value : this.exerciseNumber,
      );
  DatabaseExercise copyWithCompanion(DatabaseExercisesCompanion data) {
    return DatabaseExercise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      weight: data.weight.present ? data.weight.value : this.weight,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      exerciseNumber: data.exerciseNumber.present
          ? data.exerciseNumber.value
          : this.exerciseNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseExercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseNumber: $exerciseNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sets, reps, weight, startTime,
      endTime, workoutId, exerciseNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DatabaseExercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.weight == this.weight &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.workoutId == this.workoutId &&
          other.exerciseNumber == this.exerciseNumber);
}

class DatabaseExercisesCompanion extends UpdateCompanion<DatabaseExercise> {
  final Value<int> id;
  final Value<String?> name;
  final Value<int?> sets;
  final Value<int?> reps;
  final Value<int?> weight;
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<int?> workoutId;
  final Value<int?> exerciseNumber;
  const DatabaseExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.exerciseNumber = const Value.absent(),
  });
  DatabaseExercisesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.exerciseNumber = const Value.absent(),
  });
  static Insertable<DatabaseExercise> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<int>? weight,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? workoutId,
    Expression<int>? exerciseNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (weight != null) 'weight': weight,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (workoutId != null) 'workout_id': workoutId,
      if (exerciseNumber != null) 'exercise_number': exerciseNumber,
    });
  }

  DatabaseExercisesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<int?>? sets,
      Value<int?>? reps,
      Value<int?>? weight,
      Value<DateTime?>? startTime,
      Value<DateTime?>? endTime,
      Value<int?>? workoutId,
      Value<int?>? exerciseNumber}) {
    return DatabaseExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      workoutId: workoutId ?? this.workoutId,
      exerciseNumber: exerciseNumber ?? this.exerciseNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<int>(workoutId.value);
    }
    if (exerciseNumber.present) {
      map['exercise_number'] = Variable<int>(exerciseNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseNumber: $exerciseNumber')
          ..write(')'))
        .toString();
  }
}

class $DatabaseExerciseSetsTable extends DatabaseExerciseSets
    with TableInfo<$DatabaseExerciseSetsTable, DatabaseExerciseSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DatabaseExerciseSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
      'exercise_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _setNumberMeta =
      const VerificationMeta('setNumber');
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
      'set_number', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, exerciseId, setNumber, reps, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'database_exercise_sets';
  @override
  VerificationContext validateIntegrity(
      Insertable<DatabaseExerciseSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    }
    if (data.containsKey('set_number')) {
      context.handle(_setNumberMeta,
          setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta));
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatabaseExerciseSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatabaseExerciseSet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_id']),
      setNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_number']),
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
    );
  }

  @override
  $DatabaseExerciseSetsTable createAlias(String alias) {
    return $DatabaseExerciseSetsTable(attachedDatabase, alias);
  }
}

class DatabaseExerciseSet extends DataClass
    implements Insertable<DatabaseExerciseSet> {
  final int id;
  final int? exerciseId;
  final int? setNumber;
  final int? reps;
  final double? weight;
  const DatabaseExerciseSet(
      {required this.id,
      this.exerciseId,
      this.setNumber,
      this.reps,
      this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<int>(exerciseId);
    }
    if (!nullToAbsent || setNumber != null) {
      map['set_number'] = Variable<int>(setNumber);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    return map;
  }

  DatabaseExerciseSetsCompanion toCompanion(bool nullToAbsent) {
    return DatabaseExerciseSetsCompanion(
      id: Value(id),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
      setNumber: setNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(setNumber),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
    );
  }

  factory DatabaseExerciseSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatabaseExerciseSet(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int?>(json['exerciseId']),
      setNumber: serializer.fromJson<int?>(json['setNumber']),
      reps: serializer.fromJson<int?>(json['reps']),
      weight: serializer.fromJson<double?>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int?>(exerciseId),
      'setNumber': serializer.toJson<int?>(setNumber),
      'reps': serializer.toJson<int?>(reps),
      'weight': serializer.toJson<double?>(weight),
    };
  }

  DatabaseExerciseSet copyWith(
          {int? id,
          Value<int?> exerciseId = const Value.absent(),
          Value<int?> setNumber = const Value.absent(),
          Value<int?> reps = const Value.absent(),
          Value<double?> weight = const Value.absent()}) =>
      DatabaseExerciseSet(
        id: id ?? this.id,
        exerciseId: exerciseId.present ? exerciseId.value : this.exerciseId,
        setNumber: setNumber.present ? setNumber.value : this.setNumber,
        reps: reps.present ? reps.value : this.reps,
        weight: weight.present ? weight.value : this.weight,
      );
  DatabaseExerciseSet copyWithCompanion(DatabaseExerciseSetsCompanion data) {
    return DatabaseExerciseSet(
      id: data.id.present ? data.id.value : this.id,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      reps: data.reps.present ? data.reps.value : this.reps,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseExerciseSet(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, setNumber, reps, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DatabaseExerciseSet &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.setNumber == this.setNumber &&
          other.reps == this.reps &&
          other.weight == this.weight);
}

class DatabaseExerciseSetsCompanion
    extends UpdateCompanion<DatabaseExerciseSet> {
  final Value<int> id;
  final Value<int?> exerciseId;
  final Value<int?> setNumber;
  final Value<int?> reps;
  final Value<double?> weight;
  const DatabaseExerciseSetsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
  });
  DatabaseExerciseSetsCompanion.insert({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
  });
  static Insertable<DatabaseExerciseSet> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<int>? setNumber,
    Expression<int>? reps,
    Expression<double>? weight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (setNumber != null) 'set_number': setNumber,
      if (reps != null) 'reps': reps,
      if (weight != null) 'weight': weight,
    });
  }

  DatabaseExerciseSetsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? exerciseId,
      Value<int?>? setNumber,
      Value<int?>? reps,
      Value<double?>? weight}) {
    return DatabaseExerciseSetsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseExerciseSetsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DatabaseWorkoutsTable databaseWorkouts =
      $DatabaseWorkoutsTable(this);
  late final $DatabaseExercisesTable databaseExercises =
      $DatabaseExercisesTable(this);
  late final $DatabaseExerciseSetsTable databaseExerciseSets =
      $DatabaseExerciseSetsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [databaseWorkouts, databaseExercises, databaseExerciseSets];
}

typedef $$DatabaseWorkoutsTableCreateCompanionBuilder
    = DatabaseWorkoutsCompanion Function({
  Value<int> id,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<DateTime?> createdAt,
});
typedef $$DatabaseWorkoutsTableUpdateCompanionBuilder
    = DatabaseWorkoutsCompanion Function({
  Value<int> id,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<DateTime?> createdAt,
});

class $$DatabaseWorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $DatabaseWorkoutsTable> {
  $$DatabaseWorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DatabaseWorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $DatabaseWorkoutsTable> {
  $$DatabaseWorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DatabaseWorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DatabaseWorkoutsTable> {
  $$DatabaseWorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DatabaseWorkoutsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DatabaseWorkoutsTable,
    DatabaseWorkout,
    $$DatabaseWorkoutsTableFilterComposer,
    $$DatabaseWorkoutsTableOrderingComposer,
    $$DatabaseWorkoutsTableAnnotationComposer,
    $$DatabaseWorkoutsTableCreateCompanionBuilder,
    $$DatabaseWorkoutsTableUpdateCompanionBuilder,
    (
      DatabaseWorkout,
      BaseReferences<_$AppDatabase, $DatabaseWorkoutsTable, DatabaseWorkout>
    ),
    DatabaseWorkout,
    PrefetchHooks Function()> {
  $$DatabaseWorkoutsTableTableManager(
      _$AppDatabase db, $DatabaseWorkoutsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DatabaseWorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DatabaseWorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DatabaseWorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              DatabaseWorkoutsCompanion(
            id: id,
            startTime: startTime,
            endTime: endTime,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              DatabaseWorkoutsCompanion.insert(
            id: id,
            startTime: startTime,
            endTime: endTime,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DatabaseWorkoutsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DatabaseWorkoutsTable,
    DatabaseWorkout,
    $$DatabaseWorkoutsTableFilterComposer,
    $$DatabaseWorkoutsTableOrderingComposer,
    $$DatabaseWorkoutsTableAnnotationComposer,
    $$DatabaseWorkoutsTableCreateCompanionBuilder,
    $$DatabaseWorkoutsTableUpdateCompanionBuilder,
    (
      DatabaseWorkout,
      BaseReferences<_$AppDatabase, $DatabaseWorkoutsTable, DatabaseWorkout>
    ),
    DatabaseWorkout,
    PrefetchHooks Function()>;
typedef $$DatabaseExercisesTableCreateCompanionBuilder
    = DatabaseExercisesCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<int?> sets,
  Value<int?> reps,
  Value<int?> weight,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int?> workoutId,
  Value<int?> exerciseNumber,
});
typedef $$DatabaseExercisesTableUpdateCompanionBuilder
    = DatabaseExercisesCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<int?> sets,
  Value<int?> reps,
  Value<int?> weight,
  Value<DateTime?> startTime,
  Value<DateTime?> endTime,
  Value<int?> workoutId,
  Value<int?> exerciseNumber,
});

class $$DatabaseExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $DatabaseExercisesTable> {
  $$DatabaseExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sets => $composableBuilder(
      column: $table.sets, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workoutId => $composableBuilder(
      column: $table.workoutId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exerciseNumber => $composableBuilder(
      column: $table.exerciseNumber,
      builder: (column) => ColumnFilters(column));
}

class $$DatabaseExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $DatabaseExercisesTable> {
  $$DatabaseExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sets => $composableBuilder(
      column: $table.sets, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workoutId => $composableBuilder(
      column: $table.workoutId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exerciseNumber => $composableBuilder(
      column: $table.exerciseNumber,
      builder: (column) => ColumnOrderings(column));
}

class $$DatabaseExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DatabaseExercisesTable> {
  $$DatabaseExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get workoutId =>
      $composableBuilder(column: $table.workoutId, builder: (column) => column);

  GeneratedColumn<int> get exerciseNumber => $composableBuilder(
      column: $table.exerciseNumber, builder: (column) => column);
}

class $$DatabaseExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DatabaseExercisesTable,
    DatabaseExercise,
    $$DatabaseExercisesTableFilterComposer,
    $$DatabaseExercisesTableOrderingComposer,
    $$DatabaseExercisesTableAnnotationComposer,
    $$DatabaseExercisesTableCreateCompanionBuilder,
    $$DatabaseExercisesTableUpdateCompanionBuilder,
    (
      DatabaseExercise,
      BaseReferences<_$AppDatabase, $DatabaseExercisesTable, DatabaseExercise>
    ),
    DatabaseExercise,
    PrefetchHooks Function()> {
  $$DatabaseExercisesTableTableManager(
      _$AppDatabase db, $DatabaseExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DatabaseExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DatabaseExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DatabaseExercisesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> sets = const Value.absent(),
            Value<int?> reps = const Value.absent(),
            Value<int?> weight = const Value.absent(),
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> workoutId = const Value.absent(),
            Value<int?> exerciseNumber = const Value.absent(),
          }) =>
              DatabaseExercisesCompanion(
            id: id,
            name: name,
            sets: sets,
            reps: reps,
            weight: weight,
            startTime: startTime,
            endTime: endTime,
            workoutId: workoutId,
            exerciseNumber: exerciseNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> sets = const Value.absent(),
            Value<int?> reps = const Value.absent(),
            Value<int?> weight = const Value.absent(),
            Value<DateTime?> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> workoutId = const Value.absent(),
            Value<int?> exerciseNumber = const Value.absent(),
          }) =>
              DatabaseExercisesCompanion.insert(
            id: id,
            name: name,
            sets: sets,
            reps: reps,
            weight: weight,
            startTime: startTime,
            endTime: endTime,
            workoutId: workoutId,
            exerciseNumber: exerciseNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DatabaseExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DatabaseExercisesTable,
    DatabaseExercise,
    $$DatabaseExercisesTableFilterComposer,
    $$DatabaseExercisesTableOrderingComposer,
    $$DatabaseExercisesTableAnnotationComposer,
    $$DatabaseExercisesTableCreateCompanionBuilder,
    $$DatabaseExercisesTableUpdateCompanionBuilder,
    (
      DatabaseExercise,
      BaseReferences<_$AppDatabase, $DatabaseExercisesTable, DatabaseExercise>
    ),
    DatabaseExercise,
    PrefetchHooks Function()>;
typedef $$DatabaseExerciseSetsTableCreateCompanionBuilder
    = DatabaseExerciseSetsCompanion Function({
  Value<int> id,
  Value<int?> exerciseId,
  Value<int?> setNumber,
  Value<int?> reps,
  Value<double?> weight,
});
typedef $$DatabaseExerciseSetsTableUpdateCompanionBuilder
    = DatabaseExerciseSetsCompanion Function({
  Value<int> id,
  Value<int?> exerciseId,
  Value<int?> setNumber,
  Value<int?> reps,
  Value<double?> weight,
});

class $$DatabaseExerciseSetsTableFilterComposer
    extends Composer<_$AppDatabase, $DatabaseExerciseSetsTable> {
  $$DatabaseExerciseSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));
}

class $$DatabaseExerciseSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $DatabaseExerciseSetsTable> {
  $$DatabaseExerciseSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));
}

class $$DatabaseExerciseSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DatabaseExerciseSetsTable> {
  $$DatabaseExerciseSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);
}

class $$DatabaseExerciseSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DatabaseExerciseSetsTable,
    DatabaseExerciseSet,
    $$DatabaseExerciseSetsTableFilterComposer,
    $$DatabaseExerciseSetsTableOrderingComposer,
    $$DatabaseExerciseSetsTableAnnotationComposer,
    $$DatabaseExerciseSetsTableCreateCompanionBuilder,
    $$DatabaseExerciseSetsTableUpdateCompanionBuilder,
    (
      DatabaseExerciseSet,
      BaseReferences<_$AppDatabase, $DatabaseExerciseSetsTable,
          DatabaseExerciseSet>
    ),
    DatabaseExerciseSet,
    PrefetchHooks Function()> {
  $$DatabaseExerciseSetsTableTableManager(
      _$AppDatabase db, $DatabaseExerciseSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DatabaseExerciseSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DatabaseExerciseSetsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DatabaseExerciseSetsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> exerciseId = const Value.absent(),
            Value<int?> setNumber = const Value.absent(),
            Value<int?> reps = const Value.absent(),
            Value<double?> weight = const Value.absent(),
          }) =>
              DatabaseExerciseSetsCompanion(
            id: id,
            exerciseId: exerciseId,
            setNumber: setNumber,
            reps: reps,
            weight: weight,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> exerciseId = const Value.absent(),
            Value<int?> setNumber = const Value.absent(),
            Value<int?> reps = const Value.absent(),
            Value<double?> weight = const Value.absent(),
          }) =>
              DatabaseExerciseSetsCompanion.insert(
            id: id,
            exerciseId: exerciseId,
            setNumber: setNumber,
            reps: reps,
            weight: weight,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DatabaseExerciseSetsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DatabaseExerciseSetsTable,
        DatabaseExerciseSet,
        $$DatabaseExerciseSetsTableFilterComposer,
        $$DatabaseExerciseSetsTableOrderingComposer,
        $$DatabaseExerciseSetsTableAnnotationComposer,
        $$DatabaseExerciseSetsTableCreateCompanionBuilder,
        $$DatabaseExerciseSetsTableUpdateCompanionBuilder,
        (
          DatabaseExerciseSet,
          BaseReferences<_$AppDatabase, $DatabaseExerciseSetsTable,
              DatabaseExerciseSet>
        ),
        DatabaseExerciseSet,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DatabaseWorkoutsTableTableManager get databaseWorkouts =>
      $$DatabaseWorkoutsTableTableManager(_db, _db.databaseWorkouts);
  $$DatabaseExercisesTableTableManager get databaseExercises =>
      $$DatabaseExercisesTableTableManager(_db, _db.databaseExercises);
  $$DatabaseExerciseSetsTableTableManager get databaseExerciseSets =>
      $$DatabaseExerciseSetsTableTableManager(_db, _db.databaseExerciseSets);
}

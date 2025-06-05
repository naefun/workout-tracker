// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class DatabaseWorkouts extends Table
    with TableInfo<DatabaseWorkouts, DatabaseWorkoutsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DatabaseWorkouts(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatabaseWorkoutsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatabaseWorkoutsData(
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
  DatabaseWorkouts createAlias(String alias) {
    return DatabaseWorkouts(attachedDatabase, alias);
  }
}

class DatabaseWorkoutsData extends DataClass
    implements Insertable<DatabaseWorkoutsData> {
  final int id;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? createdAt;
  const DatabaseWorkoutsData(
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

  factory DatabaseWorkoutsData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatabaseWorkoutsData(
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

  DatabaseWorkoutsData copyWith(
          {int? id,
          Value<DateTime?> startTime = const Value.absent(),
          Value<DateTime?> endTime = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent()}) =>
      DatabaseWorkoutsData(
        id: id ?? this.id,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  DatabaseWorkoutsData copyWithCompanion(DatabaseWorkoutsCompanion data) {
    return DatabaseWorkoutsData(
      id: data.id.present ? data.id.value : this.id,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseWorkoutsData(')
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
      (other is DatabaseWorkoutsData &&
          other.id == this.id &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.createdAt == this.createdAt);
}

class DatabaseWorkoutsCompanion extends UpdateCompanion<DatabaseWorkoutsData> {
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
  static Insertable<DatabaseWorkoutsData> custom({
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

class DatabaseExercises extends Table
    with TableInfo<DatabaseExercises, DatabaseExercisesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DatabaseExercises(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
      'sets', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
      'workout_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatabaseExercisesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatabaseExercisesData(
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
  DatabaseExercises createAlias(String alias) {
    return DatabaseExercises(attachedDatabase, alias);
  }
}

class DatabaseExercisesData extends DataClass
    implements Insertable<DatabaseExercisesData> {
  final int id;
  final String? name;
  final int? sets;
  final int? reps;
  final int? weight;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? workoutId;
  final int? exerciseNumber;
  const DatabaseExercisesData(
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

  factory DatabaseExercisesData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatabaseExercisesData(
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

  DatabaseExercisesData copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<int?> sets = const Value.absent(),
          Value<int?> reps = const Value.absent(),
          Value<int?> weight = const Value.absent(),
          Value<DateTime?> startTime = const Value.absent(),
          Value<DateTime?> endTime = const Value.absent(),
          Value<int?> workoutId = const Value.absent(),
          Value<int?> exerciseNumber = const Value.absent()}) =>
      DatabaseExercisesData(
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
  DatabaseExercisesData copyWithCompanion(DatabaseExercisesCompanion data) {
    return DatabaseExercisesData(
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
    return (StringBuffer('DatabaseExercisesData(')
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
      (other is DatabaseExercisesData &&
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

class DatabaseExercisesCompanion
    extends UpdateCompanion<DatabaseExercisesData> {
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
  static Insertable<DatabaseExercisesData> custom({
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

class DatabaseExerciseSets extends Table
    with TableInfo<DatabaseExerciseSets, DatabaseExerciseSetsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DatabaseExerciseSets(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
      'exercise_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
      'set_number', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatabaseExerciseSetsData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatabaseExerciseSetsData(
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
  DatabaseExerciseSets createAlias(String alias) {
    return DatabaseExerciseSets(attachedDatabase, alias);
  }
}

class DatabaseExerciseSetsData extends DataClass
    implements Insertable<DatabaseExerciseSetsData> {
  final int id;
  final int? exerciseId;
  final int? setNumber;
  final int? reps;
  final double? weight;
  const DatabaseExerciseSetsData(
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

  factory DatabaseExerciseSetsData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatabaseExerciseSetsData(
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

  DatabaseExerciseSetsData copyWith(
          {int? id,
          Value<int?> exerciseId = const Value.absent(),
          Value<int?> setNumber = const Value.absent(),
          Value<int?> reps = const Value.absent(),
          Value<double?> weight = const Value.absent()}) =>
      DatabaseExerciseSetsData(
        id: id ?? this.id,
        exerciseId: exerciseId.present ? exerciseId.value : this.exerciseId,
        setNumber: setNumber.present ? setNumber.value : this.setNumber,
        reps: reps.present ? reps.value : this.reps,
        weight: weight.present ? weight.value : this.weight,
      );
  DatabaseExerciseSetsData copyWithCompanion(
      DatabaseExerciseSetsCompanion data) {
    return DatabaseExerciseSetsData(
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
    return (StringBuffer('DatabaseExerciseSetsData(')
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
      (other is DatabaseExerciseSetsData &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.setNumber == this.setNumber &&
          other.reps == this.reps &&
          other.weight == this.weight);
}

class DatabaseExerciseSetsCompanion
    extends UpdateCompanion<DatabaseExerciseSetsData> {
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
  static Insertable<DatabaseExerciseSetsData> custom({
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

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(e);
  late final DatabaseWorkouts databaseWorkouts = DatabaseWorkouts(this);
  late final DatabaseExercises databaseExercises = DatabaseExercises(this);
  late final DatabaseExerciseSets databaseExerciseSets =
      DatabaseExerciseSets(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [databaseWorkouts, databaseExercises, databaseExerciseSets];
  @override
  int get schemaVersion => 1;
}

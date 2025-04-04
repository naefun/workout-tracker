import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/providers/workout_provider.dart';
import 'package:gym_tracker_app/util/single_period_enforcer.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  removeSet(String setId, WidgetRef ref) {
    ref.read(setDataProvider.notifier).removeSet(setId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool workoutStatus = ref.watch(workoutStatusProvider);
    bool exerciseStatus = ref.watch(exerciseStatusProvider);
    List<ExerciseSet> sets = ref.watch(setDataProvider);
    List<Exercise> exercises = ref.watch(exerciseDataProvider);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  spacing: 14,
                  children: [
                    Text(
                      "Workout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ActivityPill(
                      active: workoutStatus,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 31,
              ),
              if (!workoutStatus)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: CardButton(
                    onTap: () =>
                        ref.read(workoutStatusProvider.notifier).startWorkout(),
                    icon: Icons.fitness_center_rounded,
                    label: "Start workout",
                  ),
                ),
              if (workoutStatus && !exerciseStatus)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: WorkoutActions(formKey: _formKey),
                ),
              if (workoutStatus && exerciseStatus)
                SizedBox(
                  height: 167,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        spacing: 10,
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: sets.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: index != sets.length - 1 ? 10 : 0),
                                  child: ExerciseSetCard(
                                    onLongPress: () => showModalBottomSheet<
                                            void>(
                                        isScrollControlled: true,
                                        useSafeArea: true,
                                        showDragHandle: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SingleChildScrollView(
                                            padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom +
                                                  50,
                                              left: 20,
                                              right: 20,
                                            ),
                                            child: Center(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      removeSet(
                                                          sets[index].id, ref);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            content: Text(
                                                                'Set removed')),
                                                      );

                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Remove set"))),
                                          );
                                        }),
                                    weight: sets[index].weight,
                                    reps: sets[index].reps,
                                    set: index + 1,
                                  ),
                                );
                              }),
                          ExerciseActions(),
                        ],
                      ),
                    ),
                  ),
                ),
              if (workoutStatus) ...[
                SizedBox(
                  height: 44,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text("Current workout",
                        style: TextStyle(
                            color: Color(0xff8F8F8F),
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
              ],
              exercises.isNotEmpty
                  ? ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 8,
                          ),
                      itemCount: exercises.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var totalSets = exercises[index].sets.length;
                        var totalReps =
                            calculateTotalRepsFromSets(exercises[index].sets);
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: (Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffE8DEF8),
                            ),
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 7, bottom: 7),
                            child: Row(
                              spacing: 6,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    exercises[index].name,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SingleChildScrollView(
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Color(0xffD1BEEF)),
                                          child: Column(
                                            children: [
                                              Text(
                                                totalSets.toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(exercises[index]
                                                          .sets
                                                          .length ==
                                                      1
                                                  ? "Set"
                                                  : "Sets"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Color(0xffD1BEEF)),
                                          child: Column(
                                            children: [
                                              Text(
                                                totalReps.toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(totalReps == 1
                                                  ? "Rep"
                                                  : "Reps"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        );
                      })
                  : Text("No exercises")
            ],
          ),
        ),
      ),
    );
  }

  num calculateTotalRepsFromSets(List<ExerciseSet> sets) {
    num result = 0;
    for (var set in sets) {
      result += num.tryParse(set.reps) ?? 0;
    }
    return result;
  }
}

class ExerciseSetCard extends StatelessWidget {
  const ExerciseSetCard({
    super.key,
    this.weight,
    this.reps,
    this.set,
    this.onLongPress,
  });

  final Function? onLongPress;
  final String? weight;
  final String? reps;
  final int? set;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (onLongPress != null) {
          onLongPress!();
        }
      },
      child: SizedBox(
        width: 120,
        child: Badge(
          backgroundColor: Color(0xff544371),
          alignment: Alignment.topLeft,
          label: Text(set != null ? "Set $set" : "Set"),
          child: Card(
            color: Color(0xffE8DEF8),
            elevation: 0,
            margin: EdgeInsets.all(0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          weight ?? "0",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            height: 1,
                            color: Color(0xff544371),
                          ),
                        ),
                        Text(
                          "KG",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1,
                            color: Color(0xffB49FD5),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          reps ?? "0",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            height: 1,
                            color: Color(0xff544371),
                          ),
                        ),
                        Text(
                          "Reps",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1,
                            color: Color(0xffB49FD5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WorkoutActions extends ConsumerStatefulWidget {
  const WorkoutActions({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  ConsumerState<WorkoutActions> createState() => _WorkoutActionsState();
}

class _WorkoutActionsState extends ConsumerState<WorkoutActions> {
  final exerciseController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    exerciseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: CardButton(
            onTap: () => {
              showModalBottomSheet<void>(
                  isScrollControlled: true,
                  useSafeArea: true,
                  showDragHandle: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 50,
                        left: 20,
                        right: 20,
                      ),
                      child: Center(
                        child: Form(
                          key: widget._formKey,
                          child: Column(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextFormField(
                                controller: exerciseController,
                                autofocus: true,
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an exercise name';
                                  }
                                  return null;
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  startExercise();
                                },
                                child: const Text('Start exercise'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
            },
            icon: Icons.add,
            label: "Add exercise",
          ),
        ),
        Expanded(
          child: CardButton(
            onTap: () => endWorkout(),
            icon: Icons.stop_rounded,
            iconColour: Color(0xffFF2F2F),
            colour: Color(0xffFFE9E9),
            textColour: Color(0xffFF2F2F),
            label: "End workout",
          ),
        ),
      ],
    );
  }

  startExercise() {
    // Validate returns true if the form is valid, or false otherwise.
    if (widget._formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Exercise started')),
      );
      String exerciseId = Uuid().v4();
      ref.read(exerciseStatusProvider.notifier).startExercise();
      ref
          .read(exerciseDataProvider.notifier)
          .addExercise(exerciseController.text, [], exerciseId);
      ref.read(currentExerciseProvider.notifier).setCurrentExercise(exerciseId);
      exerciseController.clear();
      Navigator.pop(context);
    }
  }

  endWorkout() {
    // save workout data

    // clear workout state
    ref.read(workoutStatusProvider.notifier).endWorkout();
    ref.read(exerciseDataProvider.notifier).clearExercises();
    ref.read(currentExerciseProvider.notifier).clearCurrentExercise();
  }
}

class ExerciseActions extends ConsumerStatefulWidget {
  const ExerciseActions({
    super.key,
  });

  @override
  ConsumerState<ExerciseActions> createState() => _ExerciseActionsState();
}

class _ExerciseActionsState extends ConsumerState<ExerciseActions> {
  final weightController = TextEditingController();
  final repsController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    weightController.dispose();
    repsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    weightController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return SizedBox(
      width: 120,
      child: Column(
        spacing: 10,
        children: [
          Expanded(
            child: CardButton(
              onTap: () => showModalBottomSheet<void>(
                  isScrollControlled: true,
                  useSafeArea: true,
                  showDragHandle: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 50,
                        left: 20,
                        right: 20,
                      ),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[\d\.]')),
                                  SinglePeriodEnforcer()
                                ],
                                decoration: InputDecoration(
                                  suffixIcon: Align(
                                      widthFactor: double.minPositive,
                                      alignment: Alignment.centerRight,
                                      child: Text("KG")),
                                ),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                controller: weightController,
                                autofocus: true,
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the weight';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[\d]'))
                                ],
                                decoration: InputDecoration(
                                  suffixIcon: Align(
                                      widthFactor: double.minPositive,
                                      alignment: Alignment.centerRight,
                                      child: Text("Reps")),
                                ),
                                keyboardType: TextInputType.numberWithOptions(),
                                controller: repsController,
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the number of reps';
                                  }
                                  return null;
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.

                                    var weight =
                                        num.tryParse(weightController.text);
                                    var reps =
                                        num.tryParse(repsController.text);
                                    var id = Uuid().v4();

                                    if (weight != null && reps != null) {
                                      ref.read(setDataProvider.notifier).addSet(
                                          weight.toString(),
                                          reps.toString(),
                                          id);

                                      addSet(ExerciseSet(weight.toString(),
                                          reps.toString(), id));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text('Set added')),
                                      );

                                      weightController.clear();
                                      repsController.clear();
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                                'Please input a valid number.')),
                                      );
                                    }
                                  }
                                },
                                child: const Text('Add set'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              label: "Add set",
              icon: Icons.add,
              padding: EdgeInsets.only(top: 5, left: 20, bottom: 5, right: 20),
            ),
          ),
          Expanded(
            child: CardButton(
              onTap: () => endExercise(),
              label: "End exercise",
              iconColour: Color(0xffFF2F2F),
              colour: Color(0xffFFE9E9),
              textColour: Color(0xffFF2F2F),
              icon: Icons.stop_rounded,
              padding: EdgeInsets.only(top: 5, left: 20, bottom: 5, right: 20),
            ),
          ),
        ],
      ),
    );
  }

  endExercise() {
    var sets = ref.read(setDataProvider);
    var currentExerciseId = ref.read(currentExerciseProvider);

    if (sets.isEmpty) {
      ref.read(exerciseDataProvider.notifier).removeExercise(currentExerciseId);
    }

    ref.read(exerciseStatusProvider.notifier).endExercise();
    ref.read(setDataProvider.notifier).clearSets();
  }

  addSet(ExerciseSet set) {
    var currentExerciseId = ref.read(currentExerciseProvider);
    ref.read(exerciseDataProvider.notifier).addSet(set, currentExerciseId);
  }
}

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.onTap,
    this.icon,
    this.label,
    this.iconColour,
    this.colour,
    this.textColour,
    this.padding,
  });

  final Function onTap;
  final IconData? icon;
  final String? label;
  final Color? iconColour;
  final Color? colour;
  final Color? textColour;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: colour ?? Color.fromARGB(255, 247, 236, 255),
        margin: EdgeInsets.all(0),
        elevation: 0,
        child: Padding(
          padding: padding ??
              EdgeInsets.only(top: 21, bottom: 21, left: 10, right: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.face,
                  size: 34,
                  color: iconColour ?? Color(0xff65558F),
                ),
                Text(
                  label ?? "Label",
                  style: TextStyle(
                      color: textColour ?? Color.fromARGB(255, 80, 80, 80),
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActivityPill extends StatelessWidget {
  const ActivityPill({
    super.key,
    required this.active,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 1, bottom: 1),
      decoration: BoxDecoration(
          color: active ? const Color(0xffCCFFBC) : const Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        active ? "Active" : "Inactive",
        style: TextStyle(
            color: active ? const Color(0xff2C970C) : const Color(0xffABABAB),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

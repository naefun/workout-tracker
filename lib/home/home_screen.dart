import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/home/widgets/exercise_actions.dart';
import 'package:gym_tracker_app/home/widgets/workout_actions.dart';
import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/models/exercise_set.dart';
import 'package:gym_tracker_app/state/current_workout_state.dart';
import 'package:gym_tracker_app/widgets/activity_pill.dart';
import 'package:gym_tracker_app/widgets/card_button.dart';
import 'package:gym_tracker_app/widgets/exercise_set_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var workoutProvider = ref.watch(currentWorkoutNotifierProvider);
    var workoutNotifier = ref.watch(currentWorkoutNotifierProvider.notifier);

    bool workoutStatus = workoutProvider.isInProgress;
    bool exerciseStatus = workoutProvider.currentExercise != null;
    List<ExerciseSet> sets = workoutProvider.currentExercise?.sets ?? [];
    List<Exercise> exercises = workoutProvider.exercises.reversed.toList();

    return SafeArea(
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
                onTap: () => workoutNotifier.startWorkout(),
                icon: Icons.fitness_center_rounded,
                label: "Start workout",
              ),
            ),
          if (workoutStatus && !exerciseStatus)
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: WorkoutActions(),
            ),
          if (workoutStatus && exerciseStatus) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Text(workoutProvider.currentExercise?.name ?? "",
                    style: TextStyle(
                        color: Color(0xff454545),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
            ),
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
                      ExerciseActions(),
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
                                onLongPress: () => showModalBottomSheet<void>(
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
                                                  workoutNotifier
                                                      .removeSetFromCurrentExercise(
                                                          sets[index].id);
                                                  ScaffoldMessenger.of(context)
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
                    ],
                  ),
                ),
              ),
            ),
          ],
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
            exercises.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
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
                                      scrollDirection: Axis.horizontal,
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
                        }),
                  )
                : Text("No exercises")
          ],
        ],
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

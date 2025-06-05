import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/home/widgets/completed_exercise_card.dart';
import 'package:gym_tracker_app/home/widgets/exercise_actions.dart';
import 'package:gym_tracker_app/home/widgets/past_workout_card.dart';
import 'package:gym_tracker_app/home/widgets/timer_count.dart';
import 'package:gym_tracker_app/home/widgets/workout_actions.dart';
import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/models/exercise_set.dart';
import 'package:gym_tracker_app/state/current_workout_state.dart';
import 'package:gym_tracker_app/state/past_workouts_state.dart';
import 'package:gym_tracker_app/widgets/activity_pill.dart';
import 'package:gym_tracker_app/widgets/card_button.dart';
import 'package:gym_tracker_app/widgets/exercise_set_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var workoutProvider = ref.watch(currentWorkoutNotifierProvider);
    var workoutNotifier = ref.watch(currentWorkoutNotifierProvider.notifier);

    bool workoutStatus = workoutProvider.isInProgress;
    bool exerciseStatus = workoutProvider.currentExercise != null;
    List<ExerciseSet> sets =
        workoutProvider.currentExercise?.sets.values.toList() ?? [];
    List<Exercise> exercises = workoutProvider.exercises.reversed.toList();
    List<Workout> pastWorkouts =
        ref.watch(pastWorkoutsNotifierProvider).workouts;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                if (workoutProvider.isInProgress)
                  TimerCount(
                    startTime:
                        workoutProvider.workoutStartDateTime ?? DateTime.now(),
                    isSecondary: true,
                    includeHours: true,
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 31,
          ),
          if (!workoutStatus) ...[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CardButton(
                onTap: () => workoutNotifier.startWorkout(),
                icon: Icons.fitness_center_rounded,
                label: "Start workout",
              ),
            ),
            SizedBox(
              height: 44,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text("Past Workouts",
                    style: TextStyle(
                        color: Color(0xff8F8F8F),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ListView.separated(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: pastWorkouts.length,
                  itemBuilder: (context, index) {
                    return PastWorkoutCard(workout: pastWorkouts[index]);
                  },
                ),
              ),
            ),
          ],
          if (workoutStatus && !exerciseStatus)
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: WorkoutActions(),
            ),
          if (workoutStatus && exerciseStatus) ...[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(workoutProvider.currentExercise?.name ?? "",
                      style: TextStyle(
                          color: Color(0xff454545),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  TimerCount(
                    startTime: workoutProvider.currentExercise?.startTime ??
                        DateTime.now(),
                  ),
                ],
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
                child: Text("Current Workout",
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
                          var totalReps = calculateTotalRepsFromSets(
                              exercises[index].sets.values.toList());
                          String duration = calculateDuration(
                              exercises[index].startTime,
                              exercises[index].endTime);
                          return CompletedExerciseCard(
                            exerciseName: exercises[index].name,
                            totalSets: totalSets,
                            totalReps: totalReps,
                            duration: duration,
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

  String calculateDuration(DateTime startTime, DateTime? endTime) {
    if (endTime == null) return "00:00";

    String? durationMins = endTime.difference(startTime).inMinutes.toString();
    String? durationSecs =
        (endTime.difference(startTime).inSeconds % 60).toString();

    return "${durationMins.padLeft(2, '0')}:${durationSecs.padLeft(2, '0')}";
  }
}

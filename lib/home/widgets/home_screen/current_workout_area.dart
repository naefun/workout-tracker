import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/home/widgets/stat_pair.dart';
import 'package:gym_tracker_app/home/widgets/timer_count.dart';
import 'package:gym_tracker_app/state/current_workout_state.dart';

class CurrentWorkoutArea extends ConsumerStatefulWidget {
  const CurrentWorkoutArea({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CurrentWorkoutAreaState();
}

class _CurrentWorkoutAreaState extends ConsumerState<CurrentWorkoutArea> {
  @override
  Widget build(BuildContext context) {
    var workoutProvider = ref.watch(currentWorkoutProvider);
    bool workoutInProgress = workoutProvider.isInProgress;
    bool exerciseInProgress = workoutProvider.currentExercise != null;
    final sets = workoutProvider.currentExercise?.sets.values
            .toList()
            .reversed
            .toList() ??
        [];
    final exercises = workoutProvider.exercises.reversed.toList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (!workoutInProgress)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Text(
                'Get started by starting a\nworkout!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.from(
                        alpha: 0.44, red: 0.714, green: 0.89, blue: 1),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          )
        else if (!exerciseInProgress && exercises.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Text(
                'No exercises have been\nadded to this workout yet',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.from(
                        alpha: 0.44, red: 0.714, green: 0.89, blue: 1),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        if (workoutInProgress && exerciseInProgress)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        workoutProvider.currentExercise?.name ?? "",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    TimerCount(
                      startTime: workoutProvider.currentExercise?.startTime ??
                          DateTime.now(),
                      isSecondary: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 167,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: max(sets.length, 1),
                  itemBuilder: (context, index) {
                    final exerciseSet = sets.isEmpty ? null : sets[index];
                    return sets.isEmpty
                        ? Container(
                            height: 167,
                            width: 121,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff2A343E),
                            ),
                            padding: const EdgeInsets.only(
                                bottom: 16, top: 16, left: 6, right: 6),
                            child: Center(
                              child: Text(
                                'No sets\nadded yet',
                                style: TextStyle(
                                    color: Color(0xff5B7182),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container(
                            height: 167,
                            width: 121,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff2A343E),
                            ),
                            padding: const EdgeInsets.only(
                                bottom: 16, top: 16, left: 6, right: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  exerciseSet?.weight ?? '0',
                                  style: TextStyle(
                                      height: 0.78,
                                      color: Color(0xff5B7182),
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'KG',
                                  style: TextStyle(
                                      height: 1.16,
                                      color: Color(0xff5B7182),
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  exerciseSet?.reps ?? '0',
                                  style: TextStyle(
                                      color: Color(0xff5B7182),
                                      height: 0.78,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Reps',
                                  style: TextStyle(
                                      height: 1.16,
                                      color: Color(0xff5B7182),
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 10);
                  },
                ),
              ),
            ],
          ),
        if (workoutInProgress && exercises.isNotEmpty) ...[
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 100),
              scrollDirection: Axis.vertical,
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                int exerciseReps = 0;
                int exerciseSets = exercises[index].sets.length;
                for (var set in exercises[index].sets.values) {
                  exerciseReps += int.tryParse(set.reps) ?? 0;
                }
                final exerciseDuration = exercises[index]
                    .endTime
                    ?.difference(exercises[index].startTime);
                final minutes = exerciseDuration?.inMinutes ?? 0;
                final seconds = exerciseDuration?.inSeconds ?? 0;
                final durationValue =
                    minutes > 0 ? minutes : (seconds > 0 ? seconds : 0);
                return Container(
                  height: 87,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment(0.00, 0.50),
                      end: Alignment(1.00, 0.50),
                      colors: [
                        Colors.white.withValues(alpha: 0.03),
                        const Color.fromRGBO(153, 153, 153, 0.04)
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 10, left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          exercises[index].name,
                          style: TextStyle(
                            height: 2,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: StatPair(
                              value: durationValue.toString(),
                              label: minutes > 1
                                  ? 'Mins'
                                  : minutes == 1
                                      ? 'Min'
                                      : seconds == 1
                                          ? 'Sec'
                                          : 'Secs',
                            ),
                          ),
                          Expanded(
                            child: StatPair(
                              value: exerciseSets.toString(),
                              label: exerciseSets == 1 ? 'Set' : 'Sets',
                            ),
                          ),
                          Expanded(
                            child: StatPair(
                              value: exerciseReps.toString(),
                              label: exerciseReps == 1 ? 'Rep' : 'Reps',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
            ),
          ),
        ]
      ],
    );
  }
}

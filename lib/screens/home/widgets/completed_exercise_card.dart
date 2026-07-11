import 'package:flutter/material.dart';

class CompletedExerciseCard extends StatelessWidget {
  const CompletedExerciseCard({
    super.key,
    required this.exerciseName,
    required this.totalSets,
    required this.totalReps,
    required this.duration,
  });

  final String exerciseName;
  final int totalSets;
  final num totalReps;
  final String duration;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: (Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffE8DEF8),
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
        child: Row(
          spacing: 6,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                overflow: TextOverflow.ellipsis,
                exerciseName,
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
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffD1BEEF)),
                      child: Column(
                        children: [
                          Text(
                            totalSets.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(totalSets == 1 ? "Set" : "Sets"),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffD1BEEF)),
                      child: Column(
                        children: [
                          Text(
                            totalReps.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(totalReps == 1 ? "Rep" : "Reps"),
                        ],
                      ),
                    ),
                    if (duration.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xffD1BEEF)),
                        child: Column(
                          children: [
                            Text(
                              duration,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Duration",
                            ),
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
  }
}

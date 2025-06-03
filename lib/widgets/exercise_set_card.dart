import 'package:flutter/material.dart';

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

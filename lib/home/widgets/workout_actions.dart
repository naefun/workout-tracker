import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/state/current_workout_state.dart';
import 'package:gym_tracker_app/widgets/card_button.dart';

class WorkoutActions extends ConsumerStatefulWidget {
  const WorkoutActions({
    super.key,
  });

  @override
  ConsumerState<WorkoutActions> createState() => _WorkoutActionsState();
}

class _WorkoutActionsState extends ConsumerState<WorkoutActions> {
  final _formKey = GlobalKey<FormState>();

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
                    final exerciseController = TextEditingController();
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
                                  startExercise(exerciseController.text);
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

  void startExercise(String exerciseName) {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      // Unfocus first, before any other operations
      FocusScope.of(context).unfocus();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Exercise started')),
      );

      ref
          .read(currentWorkoutProvider.notifier)
          .startExercise(exerciseName);

      Navigator.pop(context);
    }
  }

  void endWorkout() {
    //TODO: save workout data

    // clear workout state
    ref.read(currentWorkoutProvider.notifier).endWorkout();
  }
}

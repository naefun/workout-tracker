import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker_app/models/exercise_set.dart';
import 'package:gym_tracker_app/state/current_workout_state.dart';
import 'package:gym_tracker_app/util/single_period_enforcer.dart';
import 'package:gym_tracker_app/widgets/card_button.dart';
import 'package:uuid/uuid.dart';

class ExerciseActions extends ConsumerStatefulWidget {
  const ExerciseActions({
    super.key,
  });

  @override
  ConsumerState<ExerciseActions> createState() => _ExerciseActionsState();
}

class _ExerciseActionsState extends ConsumerState<ExerciseActions> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    final weightController = TextEditingController();
                    final repsController = TextEditingController();
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
                                  addSet(weightController.text,
                                      repsController.text);
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

  addSet(String weight, String reps) {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      var parsedWeight = num.tryParse(weight);
      var parsedReps = num.tryParse(reps);

      if (parsedWeight != null && parsedReps != null) {
        ref
            .read(currentWorkoutNotifierProvider.notifier)
            .addSetToCurrentExercise(weight, reps);

        // Unfocus the text fields first
        FocusScope.of(context).unfocus();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              behavior: SnackBarBehavior.floating, content: Text('Set added')),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Please input a valid number.')),
        );
      }
    }
  }

  endExercise() {
    ref.read(currentWorkoutNotifierProvider.notifier).endExercise();
  }
}

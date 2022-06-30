import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../../../../constants/style.dart';

class RestTimer extends StatefulWidget {
  const RestTimer({Key? key, required this.seconds, required this.listLength})
      : super(key: key);

  final int seconds;
  final int listLength;

  @override
  State<RestTimer> createState() => _RestTimerState();
}

class _RestTimerState extends State<RestTimer> {
  late int _counter = widget.seconds;
  late Timer _timer;
  late int listLength = widget.listLength;

  void next() {
    // if (Provider.of<WorkoutsFirestoreProvider>(context, listen: false)
    //         .exerciseInProgressIndex !=
    //     listLength - 1) {
    //   Provider.of<WorkoutsFirestoreProvider>(context, listen: false)
    //       .incrementExerciseIndex();
    // } else {
    //   Provider.of<WorkoutsFirestoreProvider>(context, listen: false)
    //       .doneWorkoutTrue();
    //   Provider.of<WorkoutsFirestoreProvider>(context, listen: false)
    //       .incrementExerciseIndex();
    // }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0
            ? _counter--
            : {
                _timer.cancel(),
                // Provider.of<WorkoutsFirestoreProvider>(context, listen: false)
                //     .restFalse(),
                next()
              };
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_counter',
      style: kInProgressExerciseStyle,
    );
  }
}

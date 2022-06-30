import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/style.dart';
import '../../../../logic/workout_bloc/workout_bloc.dart';

class WorkoutNavBar extends StatelessWidget {
  const WorkoutNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String username;
    return CurvedNavigationBar(
      animationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 400),
      backgroundColor: kMainColor,
      index: 1,
      color: kWhiteBackground,
      height: 60,
      onTap: (index) {
        //back
        if (index == 0) {
          BlocProvider.of<WorkoutBloc>(context, listen: false)
              .add(SortByCategory(0));
          Navigator.pop(context);
        }

        ///play
        if (index == 1) {
          Navigator.pushNamed(context, '/activeworkout');
        }

        ///edit
        if (index == 2) {
          Navigator.pushNamed(context, '/addworkout');
        }
        ////share
        if (index == 3) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Share Workout'),
                  content: TextField(
                    onChanged: (value) => username = value,
                    decoration: const InputDecoration(
                      hintText: 'Enter user email',
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<WorkoutBloc>(context, listen: false)
                              .add(ShareWorkout(username));
                          Navigator.pop(context);
                        },
                        child: const Text('Share')),
                  ],
                );
              });
        }
      },
      items: const [
        FaIcon(
          FontAwesomeIcons.angleLeft,
          size: 20.0,
          color: kMainColor,
        ),
        FaIcon(
          FontAwesomeIcons.play,
          size: 20.0,
          color: kMainColor,
        ),
        FaIcon(
          FontAwesomeIcons.edit,
          size: 20.0,
          color: kMainColor,
        ),
        FaIcon(
          FontAwesomeIcons.share,
          size: 20.0,
          color: kMainColor,
        )
      ],
    );
  }
}

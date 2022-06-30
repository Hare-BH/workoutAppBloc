import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workouts_app_bloc/presentation/screens/add_or_edit_workout_page.dart/add_or_edit_workout_page.dart';
import 'package:workouts_app_bloc/presentation/screens/home_page/home_page.dart';
import 'package:workouts_app_bloc/presentation/screens/shared_workouts_page.dart/shared_workouts_page.dart';

import '../../constants/style.dart';
import '../../data/navigation_key.dart';
import '../../logic/auth_cubit/auth_cubit.dart';
import '../../logic/workout_bloc/workout_bloc.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  //final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    const HomePage(),
    const HomePage(),
    AddOrEditPage(),
    const SharedWorkoutsPage(),
    const HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        key: NavigationKey.key,
        index: index,
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: kMainColor,
        buttonBackgroundColor: kWhiteBackground,
        color: kWhiteBackground,
        height: 60,
        onTap: (activeIndex) => setState(
          () {
            if (activeIndex == 2) {
              BlocProvider.of<WorkoutBloc>(context).add(ResetWorkoutFields());
            }
            if (activeIndex == 4) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Sign Out'),
                    content: const Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            CurvedNavigationBarState navState =
                                NavigationKey.key.currentState!;
                            navState.setPage(0);
                            Navigator.pop(context, '/');
                          },
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              BlocProvider.of<AuthCubit>(context).userSignOut();
                              Navigator.pop(context, '/myapp');
                            });
                          },
                          child: const Text('Sign Out')),
                    ],
                  );
                },
              );
            }

            index = activeIndex;
          },
        ),
        items: const [
          FaIcon(
            FontAwesomeIcons.home,
            size: 20.0,
            color: kMainColor,
          ),
          FaIcon(
            FontAwesomeIcons.search,
            size: 20.0,
            color: kMainColor,
          ),
          FaIcon(
            FontAwesomeIcons.plus,
            size: 20.0,
            color: kMainColor,
          ),
          FaIcon(
            FontAwesomeIcons.shareAlt,
            size: 20.0,
            color: kMainColor,
          ),
          FaIcon(
            FontAwesomeIcons.signOutAlt,
            size: 20.0,
            color: kMainColor,
          )
        ],
      ),
    );
  }
}

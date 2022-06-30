import 'package:flutter/material.dart';
import 'package:workouts_app_bloc/main.dart';
import 'package:workouts_app_bloc/presentation/screens/active_workout_page.dart/active_workout_page.dart';
import 'package:workouts_app_bloc/presentation/screens/home_page/home_page.dart';
import 'package:workouts_app_bloc/presentation/screens/auth_screens/login_page.dart';
import 'package:workouts_app_bloc/presentation/screens/auth_screens/register_page.dart';
import 'package:workouts_app_bloc/presentation/screens/shared_workouts_page.dart/shared_workouts_page.dart';

import '../../database/authentication.dart';
import '../../database/db.dart';
import '../screens/add_or_edit_workout_page.dart/add_or_edit_workout_page.dart';
import '../screens/auth_screens/reset_password_page.dart';
import '../screens/workout_page/workout_page.dart';

class AppRouter {
  // final AuthCubit _authCubit = AuthCubit(Authentication());
  // final WorkoutBloc _workoutBloc = WorkoutBloc(db: WorkoutRepository());
  // final ActiveWorkoutCubit _activeWorkoutCubit = ActiveWorkoutCubit();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/myapp':
        return MaterialPageRoute(
          builder: (_) => MyApp(
            appRouter: AppRouter(),
            authInstance: Authentication(),
            dbInstance: WorkoutRepository(),
          ),
        );

      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );

      case '/register':
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );

      case '/resetpassword':
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordPage(),
        );

      case '/addworkout':
        return MaterialPageRoute(
          builder: (_) => AddOrEditPage(),
        );

      case '/workout':
        return MaterialPageRoute(
          builder: (_) => const WorkoutPage(),
        );

      case '/activeworkout':
        return MaterialPageRoute(
          builder: (_) => const ActiveWorkoutPage(),
        );

      case '/shared':
        return MaterialPageRoute(
          builder: (_) => const SharedWorkoutsPage(),
        );
      default:
        return null;
    }
  }

  // void dispose() {
  //   _authCubit.close();
  //   _workoutBloc.close();
  // }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/database/authentication.dart';
import 'package:workouts_app_bloc/database/db.dart';
import 'package:workouts_app_bloc/logic/active_workout_cubit/active_workout_cubit.dart';
import 'package:workouts_app_bloc/logic/auth_cubit/auth_cubit.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';
import 'package:workouts_app_bloc/presentation/screens/auth_screens/login_page.dart';
import 'package:workouts_app_bloc/presentation/screens/navigation_page.dart';

import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(
      dbInstance: WorkoutRepository(),
      authInstance: Authentication(),
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Authentication authInstance;
  final WorkoutRepository dbInstance;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.authInstance,
    required this.dbInstance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      Authentication.uid = FirebaseAuth.instance.currentUser!.uid;
      Authentication.username = FirebaseAuth.instance.currentUser!.displayName!;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authInstance, dbInstance),
        ),
        BlocProvider<WorkoutBloc>(
          create: (context) => WorkoutBloc(db: dbInstance),
          lazy: false,
        ),
        BlocProvider<ActiveWorkoutCubit>(
          create: (context) => ActiveWorkoutCubit(
            workoutBloc: BlocProvider.of<WorkoutBloc>(context),
          ),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginPage()
            : const NavPage(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}

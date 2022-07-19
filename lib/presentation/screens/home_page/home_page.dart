import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workouts_app_bloc/database/authentication.dart';
import 'package:workouts_app_bloc/presentation/screens/home_page/widgets/workout_list_builder.dart';
import '../../../constants/style.dart';
import './widgets/calender_card.dart';
import './widgets/category_buttons.dart';
import './widgets/next_workout_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: kWhiteBackground,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    'Hi ${Authentication.username}!\nReady to workout? bla',
                    textAlign: TextAlign.left,
                    style: kHeaderText,
                  ),
                ),
              ],
            ),
            const CategoryButtons(),
            const SizedBox(height: 10),
            WorkoutList(context: context),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 30, left: 30, bottom: 20),
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(child: NextWorkoutCard()),
                    Expanded(child: CalenderCard()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:workouts_app_bloc/constants/style.dart';

class NextWorkoutCard extends StatelessWidget {
  const NextWorkoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Next workout!',
          style: kCardTextDarkRegular,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10, right: 15),
            // width: MediaQuery.of(context).size.width - 230,
            decoration: BoxDecoration(
              color: kWhiteBackground,
              boxShadow: kElevatedCardShadow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Arms - Intermidiate',
                    textAlign: TextAlign.left,
                    style: kCardTextDarkSmall,
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: Image.asset('images/arms.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

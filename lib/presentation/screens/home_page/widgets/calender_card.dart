import 'package:flutter/material.dart';
import 'package:workouts_app_bloc/constants/style.dart';

class CalenderCard extends StatelessWidget {
  const CalenderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: kMainColor,
              boxShadow: kElevatedCardShadow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text(
                    'Calender',
                    style: kCardText,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: kWhiteBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            'May 12th\n2022',
                            style: kCardTextDarkSmall,
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    crossAxisCount: 7),
                            itemCount: 31,
                            itemBuilder: (_, index) => Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: kMainColor,
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffDCDCDC),
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

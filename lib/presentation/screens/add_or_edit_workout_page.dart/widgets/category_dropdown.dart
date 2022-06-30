import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';

import '../../../../../constants/style.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({Key? key}) : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

Object? selected;
final List<String> items = [
  'Arms',
  'Abs',
  'Chest',
  'Legs',
  'Back',
  'Shoulders',
];

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    //selected = BlocProvider.of<WorkoutBloc>(context).activeCategory;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Container(
      height: 35,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 2)
          ]),
      child: Row(
        children: [
          const Expanded(
            child: Text('Category:',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selected,
                    icon: const FaIcon(
                      FontAwesomeIcons.angleDown,
                      color: kMainColor,
                    ),
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() {
                      selected = value;
                      BlocProvider.of<WorkoutBloc>(context, listen: false)
                          .add(SetCategory(value.toString()));
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            color: kMainColor,
          ),
        ),
      );
}

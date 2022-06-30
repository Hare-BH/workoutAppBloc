import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/constants/style.dart';
import 'package:workouts_app_bloc/data/models/category.dart';
import 'package:workouts_app_bloc/logic/workout_bloc/workout_bloc.dart';

class CategoryButtons extends StatelessWidget {
  const CategoryButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutListLoaded) {
            return buildCategoryList(state);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  ListView buildCategoryList(WorkoutListLoaded state) {
    return ListView.builder(
      physics: const ScrollPhysics(
          parent:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())),
      scrollDirection: Axis.horizontal,
      itemCount: state.categoryList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<WorkoutBloc>(context, listen: false)
                .add(SortByCategory(index));
          },
          child: CategoryButton(category: state.categoryList[index]),
        );
      },
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: category.isPressed ? kMainColor : kWhiteBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: kElevatedShadow,
      ),
      child: Text(
        category.title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: category.isPressed ? kWhiteBackground : kGrey,
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

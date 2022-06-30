import 'package:flutter/material.dart';

import '../../../../constants/style.dart';

class CategoryBar extends StatelessWidget {
  const CategoryBar({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
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
                  child: Text(
                category,
                style: kCardTextDarkRegular,
              )),
            ),
          ),
        ],
      ),
    );
  }
}

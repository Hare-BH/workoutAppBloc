import 'package:flutter/material.dart';

Color kWhiteBackground = const Color(0xffF8F8F8);
Color kBlueAccent = const Color(0xff004985);
Color kGrey = const Color(0xff0C2D48);
const Color kMainColor = Color(0xff0C2D48);
Color kGreen = const Color(0xff52FF00);

const colors = [
  Color(0xffF8F8F8),
  Color(0xff313131),
  Color(0xff3E2C65),
  Color(0xff6323ED),
  Color(0xff652C40),
  Color(0xff2C4965),
  Color(0xffE0BF80),
  Color(0xff082968),
];

List<BoxShadow> kElevatedShadow = const [
  BoxShadow(
    color: Color(0xffDCDCDC),
    offset: Offset(2, 2),
    blurRadius: 2,
    spreadRadius: 1,
  ),
  BoxShadow(
    color: Colors.white,
    offset: Offset(-2, -2),
    blurRadius: 3,
    spreadRadius: 2,
  ),
];

List<BoxShadow> kElevatedCardShadow = const [
  BoxShadow(
    color: Color(0xffDCDCDC),
    offset: Offset(4, 4),
    blurRadius: 2,
    spreadRadius: 1,
  ),
  BoxShadow(
    color: Colors.white,
    offset: Offset(-3, -3),
    blurRadius: 2,
    spreadRadius: 2,
  ),
];

TextStyle kCardText = TextStyle(
  color: kWhiteBackground,
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

TextStyle kCardTextDarkRegular = TextStyle(
  color: kGrey,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

TextStyle kCardTextDarkSmall = TextStyle(
  color: kGrey,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

TextStyle kCardTextSmall = TextStyle(
  color: kWhiteBackground,
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

TextStyle kHeaderText =
    TextStyle(color: kGrey, fontSize: 36, fontWeight: FontWeight.w600);

const TextStyle kQuoteStyle =
    TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300);

const TextStyle kInProgressTitleStyle = TextStyle(
  fontSize: 20,
  color: kMainColor,
  fontWeight: FontWeight.w700,
);

const TextStyle kInProgressExerciseStyle = TextStyle(
    color: Colors.white,
    fontSize: 36,
    fontWeight: FontWeight.w500,
    shadows: [
      BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 4),
          blurRadius: 2,
          spreadRadius: 1)
    ]);

const TextStyle kSetsRepsStyle =
    TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white);

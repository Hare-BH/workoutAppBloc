import 'package:flutter/material.dart';

class BottomRegisterText extends StatelessWidget {
  const BottomRegisterText({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Not a member? ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Raleway',
            color: Color(0xff666666),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text(
            'Register now',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Raleway',
              color: Colors.blueAccent,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

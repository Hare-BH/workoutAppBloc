import 'package:flutter/material.dart';

class BottomSignInText extends StatelessWidget {
  const BottomSignInText({
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
          'Already have an account? ',
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
            Navigator.pop(context);
          },
          child: const Text(
            'Sign In',
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

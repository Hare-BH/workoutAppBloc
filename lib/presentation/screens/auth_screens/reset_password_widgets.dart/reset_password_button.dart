import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/style.dart';
import '../../../../logic/auth_cubit/auth_cubit.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({
    Key? key,
    required this.context,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final BuildContext context;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final signInCubit = BlocProvider.of<AuthCubit>(context);
        signInCubit.sendPasswordResetEmail(_emailController.text.trim());
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 30),
        decoration: BoxDecoration(
            color: kMainColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffDCDCDC),
                offset: Offset(1, 3),
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ]),
        child: Center(
          child: Text(
            'Reset Password',
            style: TextStyle(
              color: kWhiteBackground,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

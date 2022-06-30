import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/constants/style.dart';
import 'package:workouts_app_bloc/logic/auth_cubit/auth_cubit.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.formKey,
    required this.context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> formKey;
  final BuildContext context;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isFormValid = formKey.currentState!.validate();
        if (isFormValid) {
          final signInCubit = BlocProvider.of<AuthCubit>(context);
          signInCubit.userSingIn(
              _emailController.text.trim(), _passwordController.text.trim());
          _emailController.clear();
          _passwordController.clear();
        }
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
            'Sign In',
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/style.dart';
import '../../../../logic/auth_cubit/auth_cubit.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
    required this.signupFormKey,
    required this.context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController usernameController,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _usernameController = usernameController,
        super(key: key);

  final GlobalKey<FormState> signupFormKey;
  final BuildContext context;
  final TextEditingController _usernameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isFormValid = signupFormKey.currentState!.validate();
        if (isFormValid) {
          final signInCubit = BlocProvider.of<AuthCubit>(context);
          signInCubit.userSingUp(
            username: _usernameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
        }
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 30),
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
            'Sign Up',
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

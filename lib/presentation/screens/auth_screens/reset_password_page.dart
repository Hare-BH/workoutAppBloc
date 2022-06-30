import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/style.dart';
import '../../../logic/auth_cubit/auth_cubit.dart';
import 'reset_password_widgets.dart/reset_password_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                kWhiteBackground,
                const Color(0xffE5E5E5),
              ]),
        ),
        alignment: Alignment.center,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
            if (state is ResetPasswordSent) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reset link sent. Check your email!'),
                  backgroundColor: Colors.blueAccent,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ResetPassword) {
              buildResetPageInitial();
            }
            if (state is SendingResetPassword) {
              return const CircularProgressIndicator();
            } else {
              return buildResetPageInitial();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: kWhiteBackground,
        child: const FaIcon(
          FontAwesomeIcons.angleLeft,
          size: 40.0,
          color: kMainColor,
        ),
      ),
    );
  }

  Column buildResetPageInitial() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 150,
          height: 120,
          child: Image.asset('images/wrkapplogo.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 10),
        const Text(
          'Please enter your email',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Raleway',
            color: kMainColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        buildEmailTextField(),
        const SizedBox(height: 20),
        ResetPasswordButton(
          context: context,
          emailController: _emailController,
        ),
      ],
    );
  }

  Form buildEmailTextField() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 12),
        decoration: BoxDecoration(
            color: kWhiteBackground,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffDCDCDC),
                offset: Offset(1, 3),
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ]),
        child: TextFormField(
          validator: (input) {
            const emailRegex =
                r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
            if (input != null && RegExp(emailRegex).hasMatch(input)) {
              return null;
            } else if (input != null) {
              return '  Please enter a valid email address';
            }
            return null;
          },
          controller: _emailController,
          cursorColor: kMainColor,
          obscureText: false,
          textAlign: TextAlign.center,
          style: const TextStyle(color: kMainColor, fontSize: 16.0),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kMainColor, width: 2),
            ),
            hintText: 'Email',
            hintStyle: const TextStyle(
              color: Color(0x85666666),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

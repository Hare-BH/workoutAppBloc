import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/constants/style.dart';
import 'package:workouts_app_bloc/database/authentication.dart';
import 'package:workouts_app_bloc/database/db.dart';
import 'package:workouts_app_bloc/main.dart';

import '../../../logic/auth_cubit/auth_cubit.dart';
import '../../router/app_router.dart';
import 'register_widgets/botom_sign_in_text.dart';
import 'register_widgets/sign_up_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final signupFormKey = GlobalKey<FormState>();

  ///controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Container(
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
          },
          builder: (context, state) {
            if (state is SignedOut) {
              return buildInitialSignUp();
            }
            if (state is SigningUp) {
              return const CircularProgressIndicator();
            }
            if (state is SignedIn) {
              return MyApp(
                appRouter: AppRouter(),
                authInstance: Authentication(),
                dbInstance: WorkoutRepository(),
              );
            } else {
              return buildInitialSignUp();
            }
          },
        ),
      ),
    );
  }

  Container buildInitialSignUp() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              kWhiteBackground,
              const Color(0xffE5E5E5),
            ]),
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 120,
                child:
                    Image.asset('images/wrkapplogo.png', fit: BoxFit.contain),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: kMainColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Register below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: kMainColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              buildSignUpForm(),
              SignUpButton(
                signupFormKey: signupFormKey,
                context: context,
                usernameController: _usernameController,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              BottomSignInText(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Form buildSignUpForm() {
    return Form(
        key: signupFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            buildFormField(
              hintText: 'Username',
              obscureInput: false,
              controller: _usernameController,
              validation: usernameValidation,
            ),
            buildFormField(
              hintText: 'Email',
              obscureInput: false,
              controller: _emailController,
              validation: emailValidation,
            ),
            buildFormField(
              hintText: 'Password',
              obscureInput: true,
              controller: _passwordController,
              validation: passwordValidation,
            ),
            buildFormField(
              hintText: 'Confirm Password',
              obscureInput: true,
              controller: _confirmPasswordController,
              validation: passwordValidation,
            )
          ],
        ));
  }

  Container buildFormField(
      {required String hintText,
      required bool obscureInput,
      required TextEditingController controller,
      required Function(String?) validation}) {
    return Container(
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
        validator: (input) => validation(input),
        controller: controller,
        cursorColor: kMainColor,
        obscureText: obscureInput,
        textAlign: TextAlign.center,
        style: const TextStyle(color: kMainColor, fontSize: 16.0),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kMainColor, width: 2),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0x85666666),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  String? usernameValidation(input) {
    if (input != null && input.length == 0) {
      return '  Type in your username';
    } else {
      return null;
    }
  }

  String? passwordValidation(input) {
    if (input != null) {
      if (input.length < 6) {
        return '  Short password';
      }
      if (_passwordController.text != _confirmPasswordController.text) {
        return "  Passwords don't match up";
      }
    }
    return null;
  }

  String? emailValidation(input) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (input != null && RegExp(emailRegex).hasMatch(input)) {
      return null;
    } else if (input != null) {
      return '  Please enter a valid email address';
    }
    return null;
  }
}

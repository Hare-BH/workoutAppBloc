import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_app_bloc/constants/style.dart';
import 'package:workouts_app_bloc/main.dart';

import '../../../database/authentication.dart';
import '../../../database/db.dart';
import '../../../logic/auth_cubit/auth_cubit.dart';
import '../../router/app_router.dart';
import 'login_widgets/bottom_register_text.dart';
import 'login_widgets/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
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
                builder: (_, state) {
                  if (state is SignedOut) {
                    return buildInitialSignIn();
                  }
                  if (state is SigningIn) {
                    return const CircularProgressIndicator();
                  }
                  if (state is SignedIn) {
                    return MyApp(
                      appRouter: AppRouter(),
                      authInstance: Authentication(),
                      dbInstance: WorkoutRepository(),
                    );
                  } else {
                    return buildInitialSignIn();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInitialSignIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 120,
          child: Image.asset('images/wrkapplogo.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 10),
        const Text(
          'Welcome back!',
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
          'Please Sign In',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Raleway',
            color: kMainColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        buildSignInForm(),
        const ForgotPasswordText(),
        SignInButton(
          formKey: formKey,
          context: context,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
        BottomRegisterText(context: context),
      ],
    );
  }

  Form buildSignInForm() {
    return Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Container(
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
            Container(
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
                  if (input != null && input.length < 6) {
                    return '  Short password';
                  } else {
                    return null;
                  }
                },
                controller: _passwordController,
                cursorColor: kMainColor,
                obscureText: true,
                textAlign: TextAlign.center,
                style: const TextStyle(color: kMainColor, fontSize: 16.0),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kMainColor, width: 2),
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Color(0x85666666),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ));
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/resetpassword');
        },
        child: const Text(
          'Forgot password',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Raleway',
            color: Colors.blueAccent,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

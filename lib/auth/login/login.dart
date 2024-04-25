import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../style/style.dart';
import '../cubit/auth_cubit.dart';
import '../utils/button.dart';
import '../utils/textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // * text editing controllers
  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();
  // * text editing controllers
  // ! validation key
  final _loginFormkey = GlobalKey<FormState>();
  // ! validation key

  @override
  Widget build(BuildContext context) => Form(
        key: _loginFormkey,
        child: Column(
          children: [
            const Spacer(),
            CustomTextfield(
              title: 'Email',
              hintText: 'Enter email',
              type: 'emailField',
              controller: loginEmail,
            ),
            CustomTextfield(
              title: 'Password',
              hintText: 'Enter password',
              type: 'passwordField',
              controller: loginPassword,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot password ? ',
                    style: textSmallB,
                  ),
                  Text(
                    'reset',
                    style: textSmallBoldB,
                  )
                ],
              ),
            ),
            const Spacer(),

            // * button
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedInState) {
                  Navigator.of(context).popAndPushNamed('/');
                }
                if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('error'),
                      duration: Duration(milliseconds: 600),
                    ),
                  );
                }
              },
              // * logging in drawer item
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: AuthButton(
                    title: 'Login',
                    bgColor: Colors.black,
                    icon: Icons.arrow_forward,
                    // * button
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context)
                          .emailLogin(loginEmail.text, loginPassword.text);
                    },
                    style: textBoldW,
                  ),
                );
              },
            ),
            // * logging in drawer item
          ],
        ),
      );
}

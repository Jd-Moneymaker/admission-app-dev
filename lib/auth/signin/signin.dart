import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../style/style.dart';
import '../cubit/auth_cubit.dart';
import '../utils/button.dart';
import '../utils/textfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // * text editing controllers
  final TextEditingController signinEmail = TextEditingController();
  final TextEditingController signinPhone = TextEditingController();
  final TextEditingController signinPassword = TextEditingController();
  // * text editing controllers
  // ! validation key
  final _signupFormKey = GlobalKey<FormState>();
  // ! validation key

  @override
  Widget build(BuildContext context) => Form(
        key: _signupFormKey,
        child: Column(
          children: [
            const Spacer(),
            CustomTextfield(
              title: 'Email',
              hintText: 'Enter email',
              type: 'emailField',
              controller: signinEmail,
            ),
            CustomTextfield(
              title: 'Phone',
              hintText: 'Enter number',
              type: 'phoneField',
              controller: signinPhone,
            ),
            CustomTextfield(
              title: 'Password',
              hintText: 'Enter password',
              type: 'passwordField',
              controller: signinPassword,
            ),
            const Spacer(),
            //  * sign in button
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SigninCodeSentState) {
                  Navigator.of(context).pushNamed('/');
                }
              },
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
                    title: 'Signup',
                    bgColor: Colors.black,
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      String phoneNumber = '+91${signinPhone.text}';
                      BlocProvider.of<AuthCubit>(context).emailSignin(
                        signinEmail.text,
                        phoneNumber,
                        signinPassword.text,
                      );
                    },
                    style: textBoldW,
                  ),
                );
              },
            ),
            // * signin button
          ],
        ),
      );
}

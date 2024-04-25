import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../style/style.dart';
import '../cubit/auth_cubit.dart';
import '../utils/button.dart';
import '../utils/textfield.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController signinOtp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // ! makes the screen scrollable when typing forms. it removes overflow problem
      body: SingleChildScrollView(
        // ! very important. column needs to be given a fixed height when its inside a scroll view
        reverse: true,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  // * container styling
                  child: Column(
                    children: [
                      const Spacer(),
                      CustomTextfield(
                        title: 'Otp',
                        hintText: 'Enter Otp',
                        type: 'phoneField',
                        controller: signinOtp,
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthLoggedInState) {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.of(context).pushNamed('home_screen');
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
                        builder: (context, state) {
                          if (state is AuthLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: AuthButton(
                              title: 'Verify',
                              bgColor: Colors.black,
                              icon: Icons.arrow_forward,
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .verifyOtp(signinOtp.text);
                              },
                              style: textBoldW,
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

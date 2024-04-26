// import 'package:chat_app/screens/messages/message_screen.dart';
import 'package:admission_app_dev/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../api/firebase_chat_api.dart';
import '../auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // ! do this using cubit for perforamce
  @override
  void initState() {
    super.initState();
    FirebaseChatApi.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return const MessageScreen();
            return const HomeScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}

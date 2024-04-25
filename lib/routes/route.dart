import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../auth/splashscreen/splashscreen.dart';
import '../screens/messages/message screen/message_screen.dart';
import '../screens/profile/edit profile screen/edit_profile_screen.dart';
import '../screens/profile/profile screen/profile_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ! auth screens
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case 'auth_screen':
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case 'message_screen':
        return MaterialPageRoute(builder: (_) => const MessageScreen());
      // ! auth screens

      // ! main screens
      case 'home_screen':
        return MaterialPageRoute(builder: (_) => const MessageScreen());
      case 'profile_screen':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case 'edit_profile_screen':
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      // case 'location_screen':
      //   return MaterialPageRoute(builder: (_) => const LocationScreen());
      // case 'message_screen':
      //   return MaterialPageRoute(builder: (_) => const MessageScreen());
      // // * booking screen
      // case 'booking_screen':
      //   return MaterialPageRoute(builder: (_) => const BookingScreen());
      // ! main screens

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/404.png",
                height: 500,
                width: 500,
                fit: BoxFit.contain,
              ),
              const Text('Sorry, file not found')
            ],
          ),
        ),
      ),
    );
  }
}

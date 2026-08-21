import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/passenger/home_screen.dart';
import '../screens/driver/driver_home_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String passengerHome = '/passenger_home';
  static const String driverHome = '/driver_home';
  static const String rideDetails = '/ride_details';
  static const String payment = '/payment';
  static const String rating = '/rating';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    passengerHome: (context) => const PassengerHomeScreen(),
    driverHome: (context) => const DriverHomeScreen(),
  };
}

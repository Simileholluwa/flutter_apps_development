import 'package:get/get.dart';
import 'package:mx_companion_v2/screens/introduction/introduction.dart';
import '../screens/splash_screen/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
    GetPage(name: "/", page: () => const SplashScreen()),
    GetPage(name: "/introduction", page: () => const IntroductionScreen()),
   ];
}
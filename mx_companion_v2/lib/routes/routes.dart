import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/question_paper/question_paper_controller.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import 'package:mx_companion_v2/screens/data_uploader_screen.dart';
import 'package:mx_companion_v2/screens/home/menu_screen.dart';
import 'package:mx_companion_v2/screens/introduction/introduction.dart';
import 'package:mx_companion_v2/screens/login/login.dart';
import '../controllers/questions_controller.dart';
import '../screens/home/main_screen.dart';
import '../screens/questions_page/questions_page.dart';
import '../screens/reset_password/reset_password.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/splash_screen/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: "/introduction",
          page: () => const IntroductionScreen(),
        ),
        GetPage(
          name: MainScreen.routeName,
          page: () => const MainScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 800,
          ),
          binding: BindingsBuilder(() {
            Get.put(QuestionPaperController());
            Get.put(MyZoomDrawerController());
          }),
        ),
        GetPage(
          name: "/uploader",
          page: () => const DataUploaderScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 800,
          ),
        ),
        GetPage(
          name: SignupScreen.routeName,
          page: () => const SignupScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 800,
          ),
        ),
        GetPage(
          name: ResetPassword.routeName,
          page: () => const ResetPassword(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 800,
          ),
        ),
        GetPage(
          name: QuestionsPage.routename,
          page: () => const QuestionsPage(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 800,
          ),
          binding: BindingsBuilder(() {
            Get.put(QuestionsController());
          }),
        ),
        GetPage(
          name: MenuScreen.routeName,
          page: () => const MenuScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 800,
          ),
          binding: BindingsBuilder(() {
            Get.put(MyZoomDrawerController());
          }),
        ),
      ];
}

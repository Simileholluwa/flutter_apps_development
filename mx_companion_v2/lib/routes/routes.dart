import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:mx_companion_v2/controllers/question_paper/question_paper_controller.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import 'package:mx_companion_v2/screens/data_uploader_screen.dart';
import 'package:mx_companion_v2/screens/home/menu_screen.dart';
import 'package:mx_companion_v2/screens/login/login.dart';
import 'package:mx_companion_v2/screens/questions_page/check_answer.dart';
import '../controllers/questions_controller.dart';
import '../screens/faq/faq.dart';
import '../screens/history/history.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/main_screen.dart';
import '../screens/notification/notification.dart';
import '../screens/questions_page/questions_overview.dart';
import '../screens/questions_page/questions_page.dart';
import '../screens/reset_password/reset_password.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../widgets/questions/result_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: MainScreen.routeName,
          page: () => const MainScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
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
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
          binding: BindingsBuilder(() {
            Get.put(MyZoomDrawerController());
            Get.put(QuestionPaperController());
          }),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
        ),
        GetPage(
          name: NotificationScreen.routeName,
          page: () => const NotificationScreen(),
          transition: Transition.downToUp,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
        ),
        GetPage(
          name: HistoryScreen.routeName,
          page: () => const HistoryScreen(),
          transition: Transition.downToUp,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
        ),
        GetPage(
          name: SignupScreen.routeName,
          page: () => const SignupScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
        ),
        GetPage(
          name: ResetPassword.routeName,
          page: () => const ResetPassword(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
        ),
        GetPage(
          name: QuestionsOverview.routeName,
          page: () => const QuestionsOverview(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
        ),
        GetPage(
          name: QuestionsPage.routeName,
          page: () => const QuestionsPage(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
          binding: BindingsBuilder(() {
            Get.put<QuestionsController>(QuestionsController());
            Get.put(AuthController());
          }),
        ),
        GetPage(
          name: MenuScreen.routeName,
          page: () => const MenuScreen(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
          binding: BindingsBuilder(() {
            Get.put(MyZoomDrawerController());
          }),
        ),
        GetPage(
          name: FaqScreen.routeName,
          page: () => const FaqScreen(),
          transition: Transition.downToUp,
          transitionDuration: const Duration(
            milliseconds: 400,
          ),
          binding: BindingsBuilder(() {
            Get.put(MyZoomDrawerController());
          }),
        ),
      ];
}

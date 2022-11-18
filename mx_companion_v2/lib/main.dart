import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/bindings/initial_binding.dart';
import 'package:mx_companion_v2/routes/routes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'config/themes/app_dark_theme.dart';
import 'config/themes/app_light_theme.dart';
import 'config/themes/ui_parameters.dart';
import 'controllers/theme_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBinding().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
      UIParameters.isDarkMode() ? primaryDarkColor1 : primaryLightColor1,
      systemNavigationBarIconBrightness:
      UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
      statusBarIconBrightness:
      UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
      statusBarColor:
      UIParameters.isDarkMode() ? primaryDarkColor1 : primaryLightColor1,
      systemNavigationBarDividerColor: primaryDark,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Get.find<ThemeController>().darkTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, widget) =>
          ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
          ),
      getPages: AppRoutes.routes(),
    );
  }
}
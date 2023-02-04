import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import 'main_screen.dart';
import 'menu_screen.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = "/homeScreen";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,
      ),
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            scrolledUnderElevation: 0,
          ),
          body: GetBuilder<MyZoomDrawerController>(
            builder: (_) {
              return ZoomDrawer(
                borderRadius: 20,
                mainScreenScale: 0,
                menuScreenWidth: MediaQuery.of(context).size.width * .75,
                mainScreenTapClose: true,
                disableDragGesture: true,
                controller: _.zoomDrawerController,
                angle: 0.0,
                style: DrawerStyle.defaultStyle,
                slideWidth: MediaQuery.of(context).size.width * .8,
                menuScreen: const MenuScreen(),
                mainScreen: const MainScreen(),
              );
            },
          )),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import '../../config/themes/app_dark_theme.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: transparentColor,
      ),
      child: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 30,
              right: 130,
              child: IconButton(
                icon: const Icon(Icons.close,
                  color: altTextColor,
                ),
                iconSize: 40,
                onPressed: controller.toggleDrawer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/config/themes/ui_parameters.dart';
import '../screens/questions_page/questions_overview.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      this.title = '',
      this.titleWidget,
      this.showMenu = false,
      this.onMenuTap,
      this.timer})
      : super(key: key);
  final String title;
  final Widget? titleWidget;
  final Widget? timer;
  final bool showMenu;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mobileScreenPadding,
          vertical: mobileScreenPadding,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(fontWeight: FontWeight.bold,),),
                      ),
                    )
                  : Center(child: titleWidget),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                timer ??
                    Transform.translate(
                      offset: const Offset(-14, -3),
                      child: const BackButton(),
                    ),
                if (showMenu)
                  Transform.translate(
                    offset: const Offset(10, -10),
                    child: IconButton(
                      onPressed: onMenuTap ?? () => Get.toNamed(QuestionsOverview.routeName),
                      icon: Icon(Icons.apps, size: 30,),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        80,
      );
}

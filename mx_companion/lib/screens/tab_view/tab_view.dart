import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../history_screen/history_screen.dart';
import '../practice/practice_screen.dart';
import '../profile_screen/profile_screen.dart';

class ScreensTabView extends StatelessWidget {
  const ScreensTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const TabBarView(
          physics: PageScrollPhysics(),
          children: [
            PracticeScreen(),
            HistoryScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: const [
            SizedBox(
              height: 25,
              child: Tab(
                text: 'Practice',
              ),
            ),
            SizedBox(
              height: 25,
              child: Tab(
                text: 'History',
              ),
            ),
            SizedBox(
              height: 25,
              child: Tab(
                text: 'Profile',
              ),
            ),
          ],
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          splashBorderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          unselectedLabelColor: CupertinoColors.systemGrey,
          labelColor: Colors.white,
          indicatorColor: Colors.blue.shade800,
          indicatorWeight: 4,
          indicatorPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          labelPadding: EdgeInsets.zero,
          unselectedLabelStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

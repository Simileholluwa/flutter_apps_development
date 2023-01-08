import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../hymns_categories/english_categories/english_categories.dart';
import '../hymns_categories/yoruba_categories/yoruba_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
       body: TabBarView(
          physics: PageScrollPhysics(),
          children: [
            YorubaCategories(),
            EnglishCategories(),
          ],
        ),

        bottomNavigationBar: TabBar(
          tabs: [
            SizedBox(
              height: 25,
              child: Tab(
                text: 'Yoruba',
              ),
            ),
            SizedBox(
              height: 25,
              child: Tab(
                text: 'English',
              ),
            ),
          ],
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          splashBorderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          unselectedLabelColor: CupertinoColors.systemGrey,
          labelColor: Colors.black,
          indicatorColor: Colors.deepPurple,
          indicatorWeight: 4,
          indicatorPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          labelPadding: EdgeInsets.zero,
          unselectedLabelStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

}

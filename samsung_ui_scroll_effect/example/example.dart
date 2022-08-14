import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samsung_ui_scroll_effect/samsung_ui_scroll_effect.dart';

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          physics: PageScrollPhysics(),
          children: [
            Center(child: Text('Keypad Screen Here')),
            Center(child: Text('Recent Calls Screen Here')),
            ContactScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            SizedBox(
              height: 25,
              child: Tab(
                text: 'Keypad',
              ),
            ),
            SizedBox(
              height: 25,
              child: Tab(
                text: 'Recent',
              ),
            ),
            SizedBox(
              height: 25,
              child: Tab(
                text: 'Contact',
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
          labelColor: Colors.white,
          indicatorColor: Colors.black,
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
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SamsungUiScrollEffect(
        toolbarHeight: 70,
        expandedTitle: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Phone',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: const Text(
                  '50 contacts with phone numbers',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: '',
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        collapsedTitle: Container(
          margin: const EdgeInsets.only(
            left: 10,
          ),
          child: const Text(
            'Phone',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: '',
            ),
          ),
        ),
        expandedHeight: 350,
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 15,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 25,
              left: 20,
              top: 10,
              bottom: 10,
            ),
            child: Column(
              children: [
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                        ),
                        child: const Divider(
                          height: 30,
                          color: CupertinoColors.inactiveGray,
                        ),
                      );
                    },
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const Icon(
                            CupertinoIcons.person_alt_circle,
                            size: 40,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Contact ${index + 1}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: '',
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

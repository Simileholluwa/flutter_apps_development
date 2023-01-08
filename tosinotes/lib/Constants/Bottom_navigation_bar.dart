//Bottom Navigation
import 'package:flutter/material.dart';
import 'package:tosinotes/Screens/Welcome/welcomeScreen.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

int _currentIndex = 0;
List<Widget> pages = const [
  WelcomeScreen(),
  Text('Services', style: _textStyle),
  Text('Contact', style: _textStyle),
  Text('Settings', style: _textStyle),
];

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.deepPurple.withOpacity(.1),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.black,
            animationDuration: const Duration(seconds: 1),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: _currentIndex,

            onDestinationSelected: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home, color: Colors.blue),
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.eco, color: Colors.blue),
                icon: Icon(Icons.eco_outlined, color: Colors.white),
                label: 'Services',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.person, color: Colors.blue),
                icon: Icon(Icons.person_outlined, color: Colors.white),
                label: 'Contact',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.settings, color: Colors.blue),
                icon: Icon(Icons.settings, color: Colors.white),
                label: 'Settings',
              ),
            ],
          ),
      ),
    );
  }
}

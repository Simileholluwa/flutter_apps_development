import 'package:flutter/material.dart';

//Welcome Screen
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Background(),
    );
  }
}

//background
class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      padding: EdgeInsets.only(right: size.width * .05, left: size.width * .05),
      margin: EdgeInsets.only(top: size.height * .05),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50),
              ),
            ),
          ),
          Container(
            height: 38,
            width: size.width,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              const SizedBox(width: 70),
              Container(
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/logo.png')),
                ),
              ),
                const SizedBox(width: 70),
                const CircleAvatar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  radius: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*

//body
class WelcomeScreenBody extends StatefulWidget {
  const WelcomeScreenBody({Key? key}) : super(key: key);
  @override
  State<WelcomeScreenBody> createState() => _WelcomeScreenBodyState();
}

class _WelcomeScreenBodyState extends State<WelcomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              String showName;
              if (user != null) {
                showName = user.email!;
                return BackgroundTypes(
                  images: 'assets/images/logo.png',
                  text: 'Welcome $showName',
                );
              } else {
                showName = '!';
                return BackgroundTypes(
                  images: 'assets/images/logo.png',
                  text: 'Welcome $showName',
                );
              }
            default:
              return const Text('Loading...');
          }
        });
  }
}

//background variation
class BackgroundTypes extends StatelessWidget {
  final String text;
  final String images;
  const BackgroundTypes({
    Key? key,
    required this.text,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //SizedBox(height: size.height * 0.01),
          Stack(
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Container(
                height: 15,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(images)),
                ),
              ),
            ],
          ),

          SizedBox(height: size.height * 0.05),
          SvgPicture.asset("assets/icons/chat.svg", height: size.height * .2),
          SizedBox(height: size.height * 0.03),
          const RoundedButton(text: 'Sign Up'),
          const RoundedButton1(text: 'Login'),
        ],
      ),
    );
  }
}
*/

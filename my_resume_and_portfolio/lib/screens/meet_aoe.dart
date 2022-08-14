import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_resume_and_portfolio/screens/my_profile.dart';
import 'package:my_resume_and_portfolio/widgets/icon_container.dart';
import '../app_color.dart';
import '../widgets/app_button.dart';
import '../widgets/page_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Container(
        color: backgroundColor,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconContainer(
              onTap: () {},
              containerIconColor: whiteColor,
              containerIcon: FontAwesomeIcons.house,
              containerColor: pinkColor,
            ),
            IconContainer(
              onTap: () {
                Get.offAll(() => const ResumeScreen(),
                transition: Transition.upToDown,
                  duration: const Duration(milliseconds: 800,
                  ),
                );
              },
              containerIconColor: greyColor,
              containerIcon: FontAwesomeIcons.user,
              containerColor: backgroundColor,
            ),
            IconContainer(
              onTap: () {},
              containerIconColor: greyColor,
              containerIcon: FontAwesomeIcons.briefcase,
              containerColor: backgroundColor,
            ),
            IconContainer(
              onTap: () {},
              containerIconColor: greyColor,
              containerIcon: FontAwesomeIcons.newspaper,
              containerColor: backgroundColor,
            ),
            IconContainer(
              onTap: () {},
              containerIconColor: greyColor,
              containerIcon: FontAwesomeIcons.envelopeOpen,
              containerColor: backgroundColor,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50,),
              child: const PageTitle(
                  icon: FontAwesomeIcons.house,
                  titleText: 'Meet A. O. E.',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 45,),
              height: 400,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/tosin.png'
                  ),
                  fit: BoxFit.cover,
                ),
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(15),),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    color: shadowColor,
                  ),
                  BoxShadow(
                    offset: const Offset(-5, 0),
                    blurRadius: 10,
                    color: shadowColor,
                  ),
                  BoxShadow(
                    offset: const Offset(5, 0),
                    blurRadius: 10,
                    color: shadowColor,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20,),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                text: "Hi, I\'m",
                  style: GoogleFonts.jost(
                    color: whiteColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: ' Ajanaku Oluwatosin Ezekiel.',
                      style: GoogleFonts.jost(
                        color: pinkColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' A Mobile and Web Developer.',
                      style: GoogleFonts.jost(
                        color: whiteColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ]
              ),

              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30,),
              child: Text(
                'I build and design beautiful, interactive, fully functional websites and mobile applications. My mobile apps are built using flutter framework for front end, firebase for backend and they are compatible with iOS and Android. My websites are built using ReactJS for frontend, firebase for backend and they are optimised for all screen types.',
                style: GoogleFonts.jost(
                  fontSize: 20,
                  height: 2,
                  color: greyColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 110),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    onTap: (){},
                    buttonText: 'Download Resume',
                    icon: FontAwesomeIcons.download,

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

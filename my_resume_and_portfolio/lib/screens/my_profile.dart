import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_resume_and_portfolio/app_color.dart';
import 'package:my_resume_and_portfolio/screens/meet_aoe.dart';
import '../widgets/app_button.dart';
import '../widgets/icon_container.dart';
import '../widgets/page_title.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({Key? key}) : super(key: key);

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10,),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconContainer(
              onTap: () {
                Get.offAll(() => const ProfileScreen(),
                  transition: Transition.upToDown,
                  duration: const Duration(milliseconds: 800,
                  ),
                );
              },
              containerIconColor: greyColor,
              containerIcon: FontAwesomeIcons.house,
              containerColor: backgroundColor,
            ),
            IconContainer(
              onTap: () {

              },
              containerIconColor: whiteColor,
              containerIcon: FontAwesomeIcons.user,
              containerColor: pinkColor,
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
                icon: FontAwesomeIcons.user,
                titleText: 'My Profile',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                left: 30,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // summary
                  Text(
                    'PROFILE SUMMARY',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: CupertinoColors.inactiveGray,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      'A 400 level undergraduate student of Federal University of Technology Minna, with a career goal in Information Communication Technology and actively open to opportunities in ICT related fields. I have experiences in Mobile applications development for Android and IOS, Web development, and Graphics Design. I am motivated to mastering these skills and to enrich my knowledge with new ones.',
                      style: GoogleFonts.jost(
                        fontSize: 20,
                        height: 2,
                        color: greyColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  AppButton(
                    onTap: (){},
                    buttonText: 'Download Resume',
                    icon: FontAwesomeIcons.download,
                  ),

                  const SizedBox(height: 20,),

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

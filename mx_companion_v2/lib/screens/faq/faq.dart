import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'faq_data.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  static const String routeName = "/faq";

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<Faqs> _faqs = getFaqs();
  bool expanded = false;
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
          toolbarHeight: 70,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          leading:
          Container(
            margin: const EdgeInsets.only(
              left: 15,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          title: Text(
            'FAQs',
            style: Theme.of(context).textTheme.titleLarge!.merge(
              const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                icon: expanded == false ? const Icon(Icons.open_in_full_sharp, size: 30,) : const Icon(Icons.close_fullscreen_sharp, size: 30,),
                onPressed: () {
                  expanded == false ? setState(() {
                    for(int i = 0; i < _faqs.length; i++){
                      _faqs[i].isExpanded = true;
                      expanded = true;
                    }
                  }) : setState(() {
                    for(int i = 0; i < _faqs.length; i++){
                      _faqs[i].isExpanded = false;
                      expanded = false;
                    }
                  });
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: _renderFaqs(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderFaqs() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20,),
        child: ExpansionPanelList(
          dividerColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          expandedHeaderPadding: const EdgeInsets.only(top: 0,),
          expansionCallback: (int index, bool isExpanded,) {
            setState(() {
              _faqs[index].isExpanded = !isExpanded;
            });
          },
          children: _faqs.map<ExpansionPanel>((Faqs faq){
              return ExpansionPanel(
                canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded,){
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5,),
                      child: ListTile(
                        title: Text(faq.title,
                          style: Theme.of(context).textTheme.titleMedium!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 5,),
                    child: ListTile(
                      title: Text(faq.body,),
                    ),
                  ),
                isExpanded: faq.isExpanded,
              );
            },
            ).toList(),
        ),
      ),
    );
  }
}



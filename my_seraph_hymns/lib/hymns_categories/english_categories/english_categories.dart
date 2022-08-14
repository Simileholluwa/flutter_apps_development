import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/english_hymns_data.dart';
import '../../widgets/big_text.dart';
import '../../widgets/hymns_category_widget/hymns_category_widget.dart';

class EnglishCategories extends StatefulWidget {
  const EnglishCategories({Key? key}) : super(key: key);

  @override
  State<EnglishCategories> createState() => _EnglishCategoriesState();
}

class _EnglishCategoriesState extends State<EnglishCategories> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.deepPurple,
        title: const BigText(text: 'All Hymns', color: Colors.white, size: 25,),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.favorite_sharp),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left:15, right: 15,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 5, right: 10,),
                    child: const Divider(
                      height: 20,
                      color: CupertinoColors.inactiveGray,
                    ),
                  );
                },
                itemCount: categoryTitleEnglish.length,
                itemBuilder: (context, index){
                  return HymnsCategoryWidget(
                    categoryNumber: (index + 1).toString(),
                    categoryTitle: categoryTitleEnglish[index],
                    hymnNumberRange: hymnNumberRangeEnglish[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

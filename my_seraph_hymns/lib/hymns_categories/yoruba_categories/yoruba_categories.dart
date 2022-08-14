import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_seraph_hymns/data/yoruba_hymns_data.dart';
import '../../widgets/big_text.dart';
import '../../widgets/hymns_category_widget/hymns_category_widget.dart';

class YorubaCategories extends StatefulWidget {
  const YorubaCategories({Key? key}) : super(key: key);

  @override
  State<YorubaCategories> createState() => _YorubaCategoriesState();
}

class _YorubaCategoriesState extends State<YorubaCategories> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.deepPurple,
        title: const BigText(text: 'Gbogbo Orin', color: Colors.white, size: 25,),
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
                itemCount: categoryTitle.length,
                itemBuilder: (context, index){
                  return HymnsCategoryWidget(
                    categoryNumber: (index + 1).toString(),
                    categoryTitle: categoryTitle[index],
                    hymnNumberRange: hymnNumberRange[index],
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

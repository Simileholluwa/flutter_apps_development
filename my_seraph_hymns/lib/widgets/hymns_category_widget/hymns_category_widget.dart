import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../big_text.dart';

class HymnsCategoryWidget extends StatelessWidget {
  final String categoryNumber;
  final String categoryTitle;
  final String hymnNumberRange;
  const HymnsCategoryWidget({Key? key, required this.categoryNumber, required this.categoryTitle, required this.hymnNumberRange,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.deepPurple,
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //image container
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CupertinoColors.lightBackgroundGray,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BigText(text: categoryNumber, color: Colors.black, size: 30,),
                  ],
                ),
              ),
            ),

            //text container
            Expanded(
              child: Container(
                height: 60,
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 10,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(
                        text: categoryTitle,
                        ),
                      Text(
                        hymnNumberRange,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

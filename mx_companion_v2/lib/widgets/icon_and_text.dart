import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final AssetImage image;
  final double size;
  const IconAndText({Key? key, required this.onTap, required this.text, this.size =25, required this.image,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15),),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20,),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image,
                  ),
                ),
              ),
              const SizedBox(width: 30,),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_forward_ios_sharp, color: Color(0xffeea346), size: 15,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

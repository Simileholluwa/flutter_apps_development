import 'package:flutter/material.dart';

class ContentAreaCustom extends StatelessWidget {
  final bool addPadding;
  final Widget child;
  final bool addRadius;

  const ContentAreaCustom({Key? key, this.addPadding = true, required this.child, this.addRadius = false,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: addRadius ? const BorderRadius.all(
            Radius.circular(30),
          ) : null,
      ),
      padding: addPadding ? const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ) : EdgeInsets.zero,
      child: child,
    );
  }
}

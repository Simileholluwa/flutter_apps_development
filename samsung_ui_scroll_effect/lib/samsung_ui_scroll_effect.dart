import 'package:flutter/material.dart';
import 'package:samsung_ui_scroll_effect/src/samsung_ui_scroll_effect_physics.dart';

class SamsungUiScrollEffect extends StatefulWidget {
  const SamsungUiScrollEffect({
    Key? key,
    required this.expandedTitle,
    required this.collapsedTitle,
    this.actions = const [],
    required this.children,
    this.childrenPadding = EdgeInsets.zero,
    required this.expandedHeight,
    this.toolbarHeight = kToolbarHeight,
    this.actionSpacing = 0,
    required this.backgroundColor,
    this.elevation = 12.0,
    this.globalKey,
  }) : super(key: key);

  final Widget expandedTitle;
  final Widget collapsedTitle;
  final List<Widget> actions;
  final List<Widget> children;
  final EdgeInsetsGeometry childrenPadding;
  final double expandedHeight;
  final double toolbarHeight;
  final double actionSpacing;
  final Color backgroundColor;
  final double elevation;

  /// The globalKey that is used to get innerScrollController
  /// of [NestedScrollViewState].
  ///
  /// - How to use
  ///
  /// {@animation 464 192 https://api.flutter.dev/flutter/widgets/NestedScrollViewState-class.html}
  final GlobalKey<NestedScrollViewState>? globalKey;

  @override
  SamsungUiScrollEffectState createState() => SamsungUiScrollEffectState();
}

class SamsungUiScrollEffectState extends State<SamsungUiScrollEffect>
    with SingleTickerProviderStateMixin {
  GlobalKey<NestedScrollViewState>? _nestedScrollViewStateKey;
  double? _expandedHeight;
  Future<void>? _scrollAnimate;

  @override
  void initState() {
    super.initState();
    _nestedScrollViewStateKey = widget.globalKey ?? GlobalKey();
  }

  void _snapAppBar(ScrollController controller, double snapOffset) async {
    if (_scrollAnimate != null) {
      await _scrollAnimate;
    }

    _scrollAnimate = controller.animateTo(
      snapOffset,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 150),
    );
  }

  bool _onNotification(ScrollEndNotification notification) {
    final scrollViewState = _nestedScrollViewStateKey!.currentState;
    final outerController = scrollViewState!.outerController;

    if (scrollViewState.innerController.position.pixels == 0 &&
        !outerController.position.atEdge) {
      final range = _expandedHeight! - widget.toolbarHeight;
      final snapOffset = (outerController.offset / range) > 0.5 ? range : 0.0;

      Future.microtask(() => _snapAppBar(outerController, snapOffset));
    }
    return false;
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio = (constraints.maxHeight - widget.toolbarHeight) /
        (_expandedHeight! - widget.toolbarHeight);

    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;

    return expandRatio;
  }

  Widget _extendedTitle(Animation<double> animation) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animation,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      )),
      child: Center(child: widget.expandedTitle),
    );
  }

  Widget _collapsedTitle(Animation<double> animation) {
    return FadeTransition(
      opacity: Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      )),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.only(left: 16),
          height: widget.toolbarHeight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: widget.collapsedTitle,
          ),
        ),
      ),
    );
  }

  Widget _actions() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: EdgeInsets.only(right: widget.actionSpacing),
        height: widget.toolbarHeight,
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.actions,
          ),
        ),
      ),
    );
  }

  List<Widget> _getAppBar(context, innerBoxIsScrolled) {
    return [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          backgroundColor: widget.backgroundColor,
          pinned: true,
          expandedHeight: _expandedHeight,
          toolbarHeight: widget.toolbarHeight,
          elevation: 12,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final expandRatio = _calculateExpandRatio(constraints);
              final animation = AlwaysStoppedAnimation(expandRatio);

              return Stack(
                fit: StackFit.expand,
                children: [
                  _extendedTitle(animation),
                  _collapsedTitle(animation),
                  _actions(),
                  const Align(
                    alignment: Alignment.bottomCenter,
                  )
                ],
              );
            },
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _expandedHeight = widget.expandedHeight;

    final Widget body = SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) => CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: widget.childrenPadding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int i) => widget.children[i],
                  childCount: widget.children.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return SafeArea(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: NotificationListener<ScrollEndNotification>(
          onNotification: _onNotification,
          child: NestedScrollView(
            key: _nestedScrollViewStateKey,
            physics: SamsungUiScrollPhysics(_expandedHeight!),
            headerSliverBuilder: _getAppBar,
            body: body,
          ),
        ),
      ),
    );
  }
}

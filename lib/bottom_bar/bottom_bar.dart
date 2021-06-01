import 'package:flutter/material.dart';
import 'package:tim_beta_animation/bottom_bar/widgets/bolinha_widget.dart';

import 'widgets/bottom_bar_item_widget.dart';
import 'models/bottom_item_model.dart';
import 'widgets/custom_bottom_bar_clipper.dart';

class BottomBar extends StatefulWidget {
  final List<BottomItemModel> items;

  const BottomBar({Key? key, required this.items}) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> iconAnimation;
  late Animation<double> ballAnimationUp;
  late Animation<double> ballAnimationDown;
  late AnimationController controller;

  final duration = Duration(milliseconds: 500);

  static const padding = 40.0;
  var alturaMergulhoBolinha = 75.0;
  var indexSelected = 0;
  late Widget icon;

  List<BottomItemModel> get items => widget.items;

  @override
  void initState() {
    super.initState();
    icon = items[indexSelected].icon;
    controller = AnimationController(duration: duration, vsync: this);
    animation = Tween<double>(begin: padding / 8, end: padding / 8).animate(controller);
    iconAnimation = Tween<double>(begin: indexSelected.toDouble(), end: indexSelected.toDouble()).animate(controller);
    ballAnimationDown = Tween<double>(begin: 0, end: alturaMergulhoBolinha).animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.5, curve: Curves.easeIn)));
    ballAnimationUp = Tween<double>(begin: alturaMergulhoBolinha, end: 0).animate(CurvedAnimation(parent: controller, curve: Interval(0.5, 1, curve: Curves.easeIn)));
    controller.addListener(() {
      if (controller.value == 0.5) {
        setState(() {
          icon = items[indexSelected].icon;
        });
      }
    });
  }

  double itemBoxSize = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    itemBoxSize = (MediaQuery.of(context).size.width - padding / 8) / widget.items.length;
    double newPoint = (padding / 8) + indexSelected * (3 * itemBoxSize - cutWidth) / 2;
    animation = Tween<double>(begin: _currentPoint, end: newPoint).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double _currentPoint = 0.0;
  double cutWidth = 140;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: AnimatedBuilder(
            animation: iconAnimation,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.only(left: padding + animation.value, top: ballAnimationUp.value + ballAnimationDown.value - alturaMergulhoBolinha),
                child: BolinhaWidget(icon: items[iconAnimation.value.round()].icon),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return ClipPath(
                clipper: CustomBottomBarClipper(startPoint: animation.value, cutWidth: cutWidth),
                child: child,
              );
            },
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: padding, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...items.map(
                    (item) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        iconAnimation = Tween<double>(begin: indexSelected.toDouble(), end: items.indexOf(item).toDouble()).animate(controller);
                        indexSelected = items.indexOf(item);
                        double newPoint = (padding / 8) + indexSelected * (3 * itemBoxSize - cutWidth) / 2;
                        controller.reset();
                        animation = Tween<double>(begin: _currentPoint, end: newPoint).animate(controller);
                        _currentPoint = newPoint;
                        controller.forward();
                      },
                      child: BottomBarItemWidget(
                        item: item,
                        duration: duration,
                        showIcon: items.indexOf(item) != indexSelected,
                        controller: controller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

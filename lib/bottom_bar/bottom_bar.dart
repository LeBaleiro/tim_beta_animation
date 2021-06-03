import 'package:flutter/material.dart';
import 'package:tim_beta_animation/bottom_bar/widgets/ball_widget.dart';

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
  late Animation<double> leftPaddinganimation;
  late Animation<double> iconBallAnimation;
  late Animation<double> ballAnimationUp;
  late Animation<double> ballAnimationDown;
  late AnimationController controller;

  List<BottomItemModel> get items => widget.items;

  final duration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: duration, vsync: this);
    controller.addListener(() {
      if (controller.value == 0.5) {
        setState(() {});
      }
    });
    initializePaddingAnimation();
    updateIconInsideBall();
    verticalBallMovementAnimation();
  }

  double itemBoxSize = 0.0;

  static const initialPadding = 40.0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    itemBoxSize = (MediaQuery.of(context).size.width - initialPadding / 8) / widget.items.length;
    updatePadding();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var ballDiveHeight = 75.0;

  void verticalBallMovementAnimation() {
    ballAnimationDown = Tween<double>(begin: 0, end: ballDiveHeight).animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.5, curve: Curves.easeIn)));
    ballAnimationUp = Tween<double>(begin: ballDiveHeight, end: 0).animate(CurvedAnimation(parent: controller, curve: Interval(0.5, 1, curve: Curves.easeIn)));
  }

  void initializePaddingAnimation() {
    leftPaddinganimation = Tween<double>(begin: initialPadding / 8, end: initialPadding / 8).animate(controller);
  }

  double _currentPoint = 0.0;
  var newIndexSelected = 0;
  double cutWidth = 140;

  void updatePadding() {
    double newPoint = (initialPadding / 8) + newIndexSelected * (3 * itemBoxSize - cutWidth) / 2;
    leftPaddinganimation = Tween<double>(begin: _currentPoint, end: newPoint).animate(controller);
    _currentPoint = newPoint;
  }

  int currentIndex = 0;

  void updateIconInsideBall() {
    iconBallAnimation = Tween<double>(begin: currentIndex.toDouble(), end: newIndexSelected.toDouble()).animate(controller);
  }

  void resetController() {
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: AnimatedBuilder(
            animation: iconBallAnimation,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.only(left: initialPadding + leftPaddinganimation.value, top: ballAnimationUp.value + ballAnimationDown.value - ballDiveHeight),
                child: BallWidget(icon: items[iconBallAnimation.value.round()].icon),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: AnimatedBuilder(
            animation: leftPaddinganimation,
            builder: (context, child) {
              return ClipPath(
                clipper: CustomBottomBarClipper(startPoint: leftPaddinganimation.value, cutWidth: cutWidth),
                child: child,
              );
            },
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: initialPadding, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...items.map(
                    (item) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        currentIndex = newIndexSelected;
                        newIndexSelected = items.indexOf(item);
                        updateIconInsideBall();
                        updatePadding();
                        resetController();
                      },
                      child: BottomBarItemWidget(
                        item: item,
                        duration: duration,
                        showIcon: items.indexOf(item) != newIndexSelected,
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

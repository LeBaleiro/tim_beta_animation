import 'package:flutter/material.dart';

import '../models/bottom_item_model.dart';

class BottomBarItemWidget extends StatefulWidget {
  final BottomItemModel item;
  final bool showIcon;
  final Duration duration;
  final AnimationController controller;

  BottomBarItemWidget({
    Key? key,
    required this.item,
    required this.showIcon,
    required this.duration,
    required this.controller,
  }) : super(key: key);

  @override
  _BottomBarItemWidgetState createState() => _BottomBarItemWidgetState();
}

class _BottomBarItemWidgetState extends State<BottomBarItemWidget> with SingleTickerProviderStateMixin {
  late Animation<double> iconPositionAnimation;

  @override
  void initState() {
    super.initState();
    iconPositionAnimation = Tween<double>(begin: 0, end: 0).animate(widget.controller);
  }

  @override
  void didUpdateWidget(covariant BottomBarItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    iconPositionAnimation = widget.showIcon ? Tween<double>(begin: 0, end: 0).animate(widget.controller) : Tween<double>(begin: 0, end: 25).animate(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
            animation: iconPositionAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, iconPositionAnimation.value),
                child: AnimatedOpacity(
                  duration: Duration(
                    seconds: widget.duration.inSeconds ~/ 3,
                    milliseconds: widget.duration.inMilliseconds ~/ 3,
                    microseconds: widget.duration.inMicroseconds ~/ 3,
                  ),
                  opacity: widget.showIcon ? 1.0 : 0.0,
                  child: Container(
                    height: 30,
                    width: widget.item.icon.runtimeType == Icon ? 30 : 50,
                    child: FittedBox(child: widget.item.icon),
                  ),
                ),
              );
            }),
        SizedBox(height: 20),
        Text(
          widget.item.label,
          style: TextStyle(color: Color(0xFF01243A)),
        ),
      ],
    );
  }
}

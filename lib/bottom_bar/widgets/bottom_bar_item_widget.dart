import 'package:flutter/material.dart';

import '../models/bottom_item_model.dart';

class BottomBarItemWidget extends StatefulWidget {
  final BottomItemModel item;
  BottomBarItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _BottomBarItemWidgetState createState() => _BottomBarItemWidgetState();
}

class _BottomBarItemWidgetState extends State<BottomBarItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(height: 30, width: widget.item.icon.runtimeType == Icon ? 30 : 50, child: FittedBox(child: widget.item.icon)),
        SizedBox(height: 20),
        Text(widget.item.label, style: TextStyle(color: Color(0xFF01243A))),
      ],
    );
  }
}

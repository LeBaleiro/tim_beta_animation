import 'package:flutter/material.dart';

class BolinhaWidget extends StatelessWidget {
  final Widget icon;

  const BolinhaWidget({Key? key, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(55),
      ),
      child: IconTheme(
        data: IconThemeData(
          color: Color(0xFF01243A),
        ),
        child: FittedBox(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: icon,
        )),
      ),
    );
  }
}

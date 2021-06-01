import 'package:flutter/material.dart';

import 'bottom_bar/bottom_bar.dart';
import 'mocks/items_mock.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF01243A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BottomBar(items: itemsMock),
        ],
      ),
    );
  }
}

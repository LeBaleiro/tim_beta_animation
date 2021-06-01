import 'package:flutter/material.dart';
import 'package:tim_beta_animation/bottom_bar/models/bottom_item_model.dart';

final itemsMock = [
  BottomItemModel(icon: Icon(Icons.flag), label: 'Desafios'),
  BottomItemModel(icon: Transform.rotate(child: Icon(Icons.send), angle: 345), label: 'Convite'),
  BottomItemModel(icon: Text('50MB'), label: 'Internet'),
];

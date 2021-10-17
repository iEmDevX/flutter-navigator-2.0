import 'package:flutter/material.dart';
import 'package:flutter_navigator2/color_item.dart';

class MyAppState extends ChangeNotifier {
  bool isNotFound;
  ColorItem? _color;

  ColorItem? get color => _color;

  MyAppState({this.isNotFound = false});

  set color(ColorItem? value) {
    if (value == _color) {
      return;
    }
    _color = value;
    notifyListeners();
  }
}

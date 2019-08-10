import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    print('_count数据: ${_count}');

    notifyListeners();
  }
}
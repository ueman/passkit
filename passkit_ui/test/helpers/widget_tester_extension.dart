import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpApp(Widget widget) async {
    await pumpWidget(MaterialApp(home: widget));
    await pump();
  }
}

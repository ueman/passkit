import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Useful for showing the pass in a detail view.
class KeepAlive extends StatelessWidget {
  const KeepAlive({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeepScreenAwakeWidget(
      child: FullScreenBrightnessWidget(
        child: child,
      ),
    );
  }
}

class KeepScreenAwakeWidget extends StatefulWidget {
  const KeepScreenAwakeWidget({super.key, required this.child});
  final Widget child;

  @override
  State<KeepScreenAwakeWidget> createState() => _KeepScreenAwakeWidgetState();
}

class _KeepScreenAwakeWidgetState extends State<KeepScreenAwakeWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _keepScreenAlive();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _letScreenDie();
  }

  Future<void> _keepScreenAlive() async {
    await WakelockPlus.enable();
  }

  Future<void> _letScreenDie() async {
    await WakelockPlus.disable();
  }
}

class FullScreenBrightnessWidget extends StatefulWidget {
  const FullScreenBrightnessWidget({super.key, required this.child});

  final Widget child;

  @override
  State<FullScreenBrightnessWidget> createState() =>
      _FullScreenBrightnessWidgetState();
}

class _FullScreenBrightnessWidgetState
    extends State<FullScreenBrightnessWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    _setFullBrightness();
  }

  @override
  void dispose() {
    _resetScreenBrightness();
    super.dispose();
  }

  Future<void> _setFullBrightness() async {
    await ScreenBrightness().setScreenBrightness(1.0);
  }

  Future<void> _resetScreenBrightness() async {
    await ScreenBrightness().resetScreenBrightness();
  }
}

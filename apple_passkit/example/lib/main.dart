// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:apple_passkit/apple_passkit.dart';
import 'package:flutter/services.dart';

final _applePasskitPlugin = ApplePassKit();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              final isAvailable =
                  await _applePasskitPlugin.isPassLibraryAvailable();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Is library available: $isAvailable'),
                ),
              );
            },
            child: const Text('Is library available?'),
          ),
          ElevatedButton(
            onPressed: () async {
              final canAdd = await _applePasskitPlugin.canAddPasses();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Can add passes: $canAdd')));
            },
            child: const Text('Can add passes?'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _applePasskitPlugin.addPass(await getFlightPass());
            },
            child: const Text('Add pass variant 1'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _applePasskitPlugin
                  .addPassesWithoutUI(await getMultiplePasses());
            },
            child: const Text('Add multiple passes via popup'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _applePasskitPlugin.addPasses(await getMultiplePasses());
            },
            child: const Text('Add multiple passes via ViewController'),
          ),
          ElevatedButton(
            onPressed: () async {
              final passes = await _applePasskitPlugin.passes();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Passes: ${passes.join(', ')}')));
            },
            child: const Text('Passes'),
          ),
        ],
      ),
    );
  }
}

Future<List<Uint8List>> getMultiplePasses() async {
  return [await getFlightPass()];
}

Future<Uint8List> getFlightPass() async {
  final pkPass = await rootBundle.load('assets/coupon.pkpass');
  return pkPass.buffer.asUint8List(pkPass.offsetInBytes, pkPass.lengthInBytes);
}

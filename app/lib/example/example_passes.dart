import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

class ExamplePasses extends StatefulWidget {
  const ExamplePasses({super.key});

  @override
  State<ExamplePasses> createState() => _ExamplePassesState();
}

class _ExamplePassesState extends State<ExamplePasses> {
  List<PkPass> passes = [];

  @override
  void initState() {
    super.initState();

    loadExamplePasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Passes'),
      ),
      body: passes.isEmpty
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              itemCount: passes.length,
              itemBuilder: (context, index) {
                final pass = passes[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PkPassWidget(pass: pass, onPressed: () {}),
                );
              },
            ),
    );
  }

  Future<void> loadExamplePasses() async {
    final examples = [
      'assets/examples/BoardingPass_unsigned.pkpass',
      'assets/examples/Coupon.pkpass',
      'assets/examples/Event.pkpass',
      'assets/examples/Generic.pkpass',
      'assets/examples/StoreCard.pkpass',
    ];
    for (final path in examples) {
      try {
        final data = await rootBundle.load(path);
        final pass = PkPass.fromBytes(data.buffer.asUint8List());
        passes.add(pass);
      } catch (exception, stackTrace) {
        log('$exception\n$stackTrace');
      }
    }
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    super.key,
  });

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  List<PkPass>? pkPasses;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final passes = [
      await loadPass('assets/boarding_pass.pkpass'),
      await loadPass('assets/coupon.pkpass'),
    ];
    setState(() {
      pkPasses = passes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final passes = pkPasses;
    if (passes == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('PkPass Example')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: passes.length,
        itemBuilder: (context, index) {
          return PkPassWidget(pass: pkPasses![index], onPressed: () {});
        },
      ),
    );
  }
}

Future<PkPass> loadPass(String path) async {
  final passData = await rootBundle.load(path);
  final list = passData.buffer
      .asUint8List(passData.offsetInBytes, passData.lengthInBytes);
  return PkPass.fromBytes(list);
}

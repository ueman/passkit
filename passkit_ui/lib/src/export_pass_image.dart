import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'dart:ui' as ui;

import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

/// Creates a PNG from the given [pass]
///
/// Remarks:
/// - Sometimes, images aren't correctly rendered on a pass
@experimental
Future<Uint8List?> exportPassAsImage(
  PkPass pass, {
  Size logicalSize = const Size(320, 460),
  double pixelRatio = 3,
}) async {
  final repaintBoundary = RenderRepaintBoundary();
  final pipelineOwner = PipelineOwner();
  final buildOwner = BuildOwner(focusManager: FocusManager());

  try {
    final renderView = RenderView(
      view: ui.PlatformDispatcher.instance.implicitView!,
      child: RenderPositionedBox(
        alignment: Alignment.center,
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        logicalConstraints: BoxConstraints.tight(logicalSize),
        devicePixelRatio: pixelRatio,
      ),
    );

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final widget = MediaQuery(
      data: MediaQueryData(devicePixelRatio: pixelRatio),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: PkPassWidget(pass: pass),
            ),
          ],
        ),
      ),
    );

    final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: widget,
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);
    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();
    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final image = await repaintBoundary.toImage(pixelRatio: pixelRatio);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData?.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    );
  } catch (e) {
    throw Exception('Failed to render the widget: $e');
  }
}

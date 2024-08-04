import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:passkit/passkit.dart';
import 'package:passkit_ui/passkit_ui.dart';

/// Creates a PNG from the given [pass]
Future<Uint8List?> exportPassAsImage(
  PkPass pass, {
  Size logicalSize = const Size(320, 460),
  double pixelRatio = 3,
}) async {
  /// finding the widget in the current context by the key.
  final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

  /// create a new pipeline owner
  final PipelineOwner pipelineOwner = PipelineOwner();

  /// create a new build owner
  final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

  try {
    final RenderView renderView = RenderView(
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

    /// setting the rootNode to the renderview of the widget
    pipelineOwner.rootNode = renderView;

    /// setting the renderView to prepareInitialFrame
    renderView.prepareInitialFrame();

    /// setting the rootElement with the widget that has to be captured
    final RenderObjectToWidgetElement<RenderBox> rootElement =
        RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: MediaQuery(
        data: MediaQueryData(devicePixelRatio: pixelRatio),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            // image is center aligned
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: PkPassWidget(pass: pass),
              ),
            ],
          ),
        ),
      ),
    ).attachToRenderTree(buildOwner);

    ///adding the rootElement to the buildScope
    buildOwner.buildScope(rootElement);

    ///adding the rootElement to the buildScope
    buildOwner.buildScope(rootElement);

    /// finalize the buildOwner
    buildOwner.finalizeTree();

    ///Flush Layout
    pipelineOwner.flushLayout();

    /// Flush Compositing Bits
    pipelineOwner.flushCompositingBits();

    /// Flush paint
    pipelineOwner.flushPaint();

    final ui.Image image =
        await repaintBoundary.toImage(pixelRatio: pixelRatio);

    /// The raw image is converted to byte data.
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData?.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  } catch (e) {
    throw Exception('Failed to render the widget: $e');
  }
}

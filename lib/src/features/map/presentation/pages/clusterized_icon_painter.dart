import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

class ClusterIconPainter {
  const ClusterIconPainter(this.clusterSize);

  final int clusterSize;

  Future<Uint8List> getClusterIconBytes() async {
    const size = Size(150, 150);
    final recorder = PictureRecorder();

    final canvas = _drawCircleBackground(size: size, recorder: recorder);

    _drawTextCount(
      text: clusterSize.toString(),
      size: size,
      canvas: canvas,
    );

    final image = await recorder.endRecording().toImage(
          size.width.toInt(),
          size.height.toInt(),
        );
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }
}

Canvas _drawCircleBackground({
  required Size size,
  required PictureRecorder recorder,
}) {
  final canvas = Canvas(recorder);
  final center = Offset(size.width / 2, size.height / 2);
  final radius = size.width / 2.2;

  final fillPaint = Paint()
    ..color = Colors.yellow
    ..style = PaintingStyle.fill;

  final borderPaint = Paint()
    ..color = Colors.deepOrangeAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8;

  canvas
    ..drawCircle(center, radius, fillPaint)
    ..drawCircle(center, radius, borderPaint);

  return canvas;
}

void _drawTextCount({
  required String text,
  required Size size,
  required Canvas canvas,
}) {
  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.deepOrangeAccent,
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: size.width);

  final offset = Offset(
    (size.width - textPainter.width) / 2,
    (size.height - textPainter.height) / 2,
  );

  textPainter.paint(canvas, offset);
}

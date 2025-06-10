import 'dart:math';

import 'package:flutter/material.dart';

class BubbleCustomPainter {
  BubbleCustomPainter({
    this.parentForcedSize,
    BorderRadius? borderRadius,
    this.arrowHeight = 10,
    this.arrowWidth = 10,
    this.arrowPositionPercent = 0.5,
  }) {
    this.borderRadius = borderRadius ?? BorderRadius.circular(12);
  }

  late final BorderRadius borderRadius;
  
  final Size? parentForcedSize;

  final double arrowHeight;
  final double arrowWidth;

  final double arrowPositionPercent;

  Path build({Rect? rect, double? scale}) {
    return generatePath(rect: rect!);
  }

  Path generatePath({required Rect rect}) {
    final path = Path();
    
    final topLeftDiameter = max(borderRadius.topLeft.x, 0);
    final topRightDiameter = max(borderRadius.topRight.x, 0);
    final bottomLeftDiameter = max(
      arrowPositionPercent == 0.0 ? 0 : borderRadius.bottomLeft.x,
      0,
    );
    final bottomRightDiameter = max(
      arrowPositionPercent == 1.0 ? 0 : borderRadius.bottomRight.x,
      0,
    );

    final left = rect.left;
    final top = rect.top;
    final right = rect.right;
    final bottom = rect.bottom - arrowHeight;

    final parentWidth = parentForcedSize?.width ?? (rect.left + rect.right);

    final centerX = parentWidth * arrowPositionPercent;
    
    path
      ..moveTo(left + topLeftDiameter / 2.0, top)
      ..lineTo(right - topRightDiameter / 2.0, top)
      ..quadraticBezierTo(
        right,
        top,
        right,
        top + topRightDiameter / 2,
      )
      ..lineTo(right, bottom - bottomRightDiameter / 2)
      ..quadraticBezierTo(
        right,
        bottom,
        right - bottomRightDiameter / 2,
        bottom,
      )
      ..lineTo(centerX + arrowWidth, bottom)
      ..lineTo(centerX, rect.bottom)
      ..lineTo(centerX - arrowWidth, bottom)
      ..lineTo(left + bottomLeftDiameter / 2, bottom)
      ..quadraticBezierTo(left, bottom, left, bottom - bottomLeftDiameter / 2)
      ..lineTo(left, top + topLeftDiameter / 2)
      ..quadraticBezierTo(left, top, left + topLeftDiameter / 2, top)
      ..close();

    return path;
  }
}

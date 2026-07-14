import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlassRenderer extends StatelessWidget {
  final Widget child;
  final double blur;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const LiquidGlassRenderer({
    super.key,
    required this.child,
    this.blur = 20,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    /// Premium adaptive glass tint
    final Color glassColor = color ??
        (brightness == Brightness.dark
            ? Colors.white.withOpacity(0.12)
            : Colors.white.withOpacity(0.2));

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: glassColor,

            /// Border tăng contrast với màu kính
            border: Border.all(
              color: Colors.white.withOpacity(0.24),
              width: 0.8,
            ),

            /// Shadow tạo separation
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// LiquidGlassStyle glassForBackground(bool isBright) {
//   return isBright
//       ? const LiquidGlassStyle(
//           blur: 18,
//           overlayOpacity: 0.26,
//           gradientOpacity: 0.30,
//           borderOpacity: 0.32,
//         )
//       : const LiquidGlassStyle(
//           blur: 14,
//           overlayOpacity: 0.14,
//           gradientOpacity: 0.18,
//           borderOpacity: 0.18,
//         );
// }

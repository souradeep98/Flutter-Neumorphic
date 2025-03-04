import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import 'package:flutter_neumorphic/src/neumorphic_box_shape.dart';
import 'package:flutter_neumorphic/src/decoration/neumorphic_decorations.dart';
import 'package:flutter_neumorphic/src/theme/neumorphic_theme.dart';
import 'package:flutter_neumorphic/src/widget/clipper/neumorphic_box_shape_clipper.dart';

export '../neumorphic_box_shape.dart';
export '../decoration/neumorphic_decorations.dart';
export '../theme/neumorphic_theme.dart';

/// The main container of the Neumorphic UI KIT
/// it takes a Neumorphic style @see [NeumorphicStyle]
///
/// it's clipped using a [NeumorphicBoxShape] (circle, roundRect, stadium)
///
/// It can be, depending on its [NeumorphicStyle.shape] : [NeumorphicShape.concave],  [NeumorphicShape.convex],  [NeumorphicShape.flat]
///
/// if [NeumorphicStyle.depth] < 0 ----> use the emboss shape
///
/// The container animates any change for you, with [duration] ! (including style / theme / size / etc.)
///
/// [drawSurfaceAboveChild] enable to draw emboss, concave, convex effect above this widget child
///
/// drawSurfaceAboveChild - UseCase 1 :
///
///   put an image inside a neumorphic(concave) :
///   drawSurfaceAboveChild=false -> the concave effect is below the image
///   drawSurfaceAboveChild=true -> the concave effect is above the image, the image seems concave
///
/// drawSurfaceAboveChild - UseCase 2 :
///   put an image inside a neumorphic(emboss) :
///   drawSurfaceAboveChild=false -> the emboss effect is below the image -> not visible
///   drawSurfaceAboveChild=true -> the emboss effect effect is above the image -> visible
///
@immutable
class Neumorphic extends StatelessWidget {
  static const Duration DEFAULT_DURATION = Duration(milliseconds: 100);
  static const material.Curve DEFAULT_CURVE = Curves.linear;

  static const double MIN_DEPTH = -20.0;
  static const double MAX_DEPTH = 20.0;

  static const double MIN_INTENSITY = 0.0;
  static const double MAX_INTENSITY = 1.0;

  static const double MIN_CURVE = 0.0;
  static const double MAX_CURVE = 1.0;

  final Widget? child;

  final NeumorphicStyle? style;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Curve curve;
  final Duration duration;
  // if true => boxDecoration & foreground decoration, else => boxDecoration does all the work
  final bool drawSurfaceAboveChild;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Matrix4? transform;
  final AlignmentGeometry? alignment;

  const Neumorphic({
    super.key,
    this.child,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.style,
    this.textStyle,
    this.margin,
    this.padding,
    this.drawSurfaceAboveChild = true,
    this.height,
    this.width,
    this.constraints,
    this.transform,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    final NeumorphicStyle style =
        (this.style ?? const NeumorphicStyle())
            .copyWithThemeIfNull(theme)
            .applyDisableDepth();

    final NeumorphicBoxShape shape =
        style.boxShape ?? const NeumorphicBoxShape.rect();

    return DefaultTextStyle(
      style: textStyle ?? material.Theme.of(context).textTheme.bodyMedium!,
      child: AnimatedContainer(
        constraints: constraints,
        width: width,
        height: height,
        margin: margin,
        duration: duration,
        curve: curve,
        padding: padding,
        transform: transform,
        alignment: alignment,
        child: NeumorphicBoxShapeClipper(shape: shape, child: child),
        foregroundDecoration: NeumorphicDecoration(
          isForeground: true,
          renderingByPath: shape.customShapePathProvider.oneGradientPerPath,
          splitBackgroundForeground: drawSurfaceAboveChild,
          style: style,
          shape: shape,
        ),
        decoration: NeumorphicDecoration(
          isForeground: false,
          renderingByPath: shape.customShapePathProvider.oneGradientPerPath,
          splitBackgroundForeground: drawSurfaceAboveChild,
          style: style,
          shape: shape,
        ),
      ),
    );
  }
}

/// Not Animated version of Neumorphic Container
@immutable
class NeumorphicNA extends StatelessWidget {
  final Widget? child;
  final NeumorphicStyle? style;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  // if true => boxDecoration & foreground decoration, else => boxDecoration does all the work
  final bool drawSurfaceAboveChild;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Matrix4? transform;
  final AlignmentGeometry? alignment;

  const NeumorphicNA({
    super.key,
    this.child,
    this.style,
    this.textStyle,
    this.margin,
    this.padding,
    this.drawSurfaceAboveChild = true,
    this.height,
    this.width,
    this.constraints,
    this.transform,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    final NeumorphicStyle style =
        (this.style ?? const NeumorphicStyle())
            .copyWithThemeIfNull(theme)
            .applyDisableDepth();

    final NeumorphicBoxShape shape =
        style.boxShape ?? const NeumorphicBoxShape.rect();

    return DefaultTextStyle(
      style: textStyle ?? material.Theme.of(context).textTheme.bodyMedium!,
      child: Container(
        alignment: alignment,
        transform: transform,
        constraints: constraints,
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        child: NeumorphicBoxShapeClipper(shape: shape, child: child),
        foregroundDecoration: NeumorphicDecoration(
          isForeground: true,
          renderingByPath: shape.customShapePathProvider.oneGradientPerPath,
          splitBackgroundForeground: drawSurfaceAboveChild,
          style: style,
          shape: shape,
        ),
        decoration: NeumorphicDecoration(
          isForeground: false,
          renderingByPath: shape.customShapePathProvider.oneGradientPerPath,
          splitBackgroundForeground: drawSurfaceAboveChild,
          style: style,
          shape: shape,
        ),
      ),
    );
  }
}

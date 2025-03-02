import 'package:flutter/widgets.dart';

import 'package:flutter_neumorphic/src/neumorphic_box_shape.dart';

class NeumorphicBoxShapeClipper extends StatelessWidget {
  final NeumorphicBoxShape shape;
  final Widget? child;
  final Clip clipBehavior;

  const NeumorphicBoxShapeClipper({
    required this.shape,
    this.child,
    super.key,
    this.clipBehavior = Clip.antiAlias,
  });

  CustomClipper<Path>? _getClipper(NeumorphicBoxShape shape) {
    return shape.customShapePathProvider;
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _getClipper(shape),
      child: child,
      clipBehavior: clipBehavior,
    );
  }
}

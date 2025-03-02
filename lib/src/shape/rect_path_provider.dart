import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RectPathProvider extends NeumorphicPathProvider {
  const RectPathProvider({super.reclip});

  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..close();
  }

  @override
  bool get oneGradientPerPath => false;
}

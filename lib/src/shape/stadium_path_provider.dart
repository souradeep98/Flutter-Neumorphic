import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_neumorphic/src/shape/rrect_path_provider.dart';

class StadiumPathProvider extends RRectPathProvider {
  const StadiumPathProvider({super.reclip})
    : super(const BorderRadius.all(Radius.circular(1000)));
}

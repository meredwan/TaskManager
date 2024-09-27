import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/ui/utils/assets_path.dart';

class Screen_BG extends StatelessWidget {
  const Screen_BG({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size ScreenSize = MediaQuery.sizeOf(context);
    return Stack(children: [
      SvgPicture.asset(
        AssetsPath.backgroundSVG,
        fit: BoxFit.cover,
        height: ScreenSize.height,
        width: ScreenSize.width,
      ),
      SafeArea(child: child)
    ]);
  }
}

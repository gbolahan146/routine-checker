
import 'package:flutter/material.dart';
import 'package:routinechecker/src/config/styles/colors.dart';

class Indicator extends StatelessWidget {
  Indicator({
    required this.controller,
    this.itemCount = 0,
    this.size = 9.0,
  }) : assert(controller != null);

  final PageController? controller;
  final int itemCount;
  final Color normalColor = CbColors.cDarken2;
  final Color selectedColor = CbColors.cPrimaryBase;
  final double size;
  final double spacing = 6.0;

  Widget _buildIndicator(
      int index, int pageCount, double dotSize, double spacing) {
    final bool isCurrentPageSelected = index ==
        (controller!.page != null ? controller!.page!.round() % pageCount : 0);

    return Container(
      height: size,
      width: size + (2 * spacing),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: isCurrentPageSelected ? 24 : dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              shape:
                  isCurrentPageSelected ? BoxShape.rectangle : BoxShape.circle,
              color: isCurrentPageSelected ? selectedColor : normalColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (int index) {
        return _buildIndicator(index, itemCount, size, spacing);
      }),
    );
  }
}

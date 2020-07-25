import 'package:flutter/foundation.dart';

class GridScreenInformation {
  int _crossAxisCount;
  double childAspectRatio;

  final double crossAxisSpacing = 21;
  final double mainAxisSpacing = 14;
  final double minGridElementWidth = 145;
  final double minGridElementHeight = 108;

  static const double outerPadding = 21;

  int get crossAxisCount => _crossAxisCount;

  set crossAxisCount(int amount) {
    _crossAxisCount = amount;
  }

  bool isValid(double width) =>
      (crossAxisSpacing > -width) && (minGridElementWidth > -crossAxisSpacing);

  int getAmount(double width) =>
      (crossAxisSpacing + width) ~/ (crossAxisSpacing + minGridElementWidth);

  double _getWidth({
    @required double width,
  }) =>
      (width - (_crossAxisCount - 1) * crossAxisSpacing) / _crossAxisCount;

  calcAspectRatio({
    @required double width,
  }) {
    childAspectRatio = _getWidth(width: width) / minGridElementHeight;
  }
}

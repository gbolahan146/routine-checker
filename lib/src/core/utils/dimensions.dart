import 'package:flutter/widgets.dart'
    show
        BuildContext,
        MediaQuery,
        MediaQueryData,
        EdgeInsets,
        RenderBox,
        Offset;
// import 'package:tellerpay/models/enums/screen_type.dart';

class _TpDimension {
  MediaQueryData? _queryData;

  _TpDimension(BuildContext context) {
    _queryData = MediaQuery.of(context);
  }

  // ScreenType get screenType {
  //   if (_queryData.size.width > 500) return ScreenType.TABLET;
  //   return ScreenType.MOBILE;
  // }

  double get topInset {
    return _queryData!.padding.top;
  }

  double get width {
    return _queryData!.size.shortestSide;
  }

  double get height {
    return _queryData!.size.longestSide;
  }

  double setHeight(double percentage) {
    if (percentage == 0) {
      return 0;
    }
    return height * (percentage / 100);
  }

  double setWidth(double percentage) {
    if (percentage == 0) {
      return 0;
    }
    return width * (percentage / 100);
  }
}

class _TpFontSizer {
  num? _scale;

  _TpFontSizer(BuildContext context) {
    _scale = (MediaQuery.of(context).size.longestSide +
            MediaQuery.of(context).size.shortestSide) /
        4;
  }

  double sp(double? percentage) {
    return (_scale! * ((percentage ?? 35) / (1000 - 50))).toDouble();
  }
}

class SizeConfig {
  factory SizeConfig() {
    return _instance!;
  }
  SizeConfig._();

  static SizeConfig? _instance;

  static _TpFontSizer? fontSizer;
  static _TpDimension? sizer;

  static void init(BuildContext context) {
    _instance ??= SizeConfig._();
    fontSizer = _TpFontSizer(context);
    sizer = _TpDimension(context);
  }

  double sp(double percentage) {
    return fontSizer!.sp(percentage * 3);
  }

  double sh(double percentage) {
    return sizer!.setHeight(percentage / 8);
  }

  double sw(double percentage) {
    return sizer!.setWidth(percentage / 4);
  }
}

class _TpInsets {
  _TpDimension? sizer;

  _TpInsets(BuildContext context) {
    sizer = _TpDimension(context);
  }

  EdgeInsets get zero {
    return EdgeInsets.zero;
  }

  EdgeInsets all(double inset) {
    return EdgeInsets.all(sizer!.setWidth(inset));
  }

  EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      top: sizer!.setHeight(top),
      left: sizer!.setWidth(left),
      bottom: sizer!.setHeight(bottom),
      right: sizer!.setWidth(right),
    );
  }

  EdgeInsets fromLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return EdgeInsets.fromLTRB(
      sizer!.setWidth(left),
      sizer!.setHeight(top),
      sizer!.setWidth(right),
      sizer!.setHeight(bottom),
    );
  }

  EdgeInsets symmetric({
    double vertical = 0,
    double horizontal = 0,
  }) {
    return EdgeInsets.symmetric(
      vertical: sizer!.setHeight(vertical),
      horizontal: sizer!.setWidth(horizontal),
    );
  }
}

class TpScaleUtil {
  final BuildContext context;

  TpScaleUtil(this.context);

  _TpDimension get sizer => _TpDimension(context);
  _TpFontSizer get fontSizer => _TpFontSizer(context);
  _TpInsets get insets => _TpInsets(context);
}

Offset getPos(BuildContext context) {
  final RenderBox box = context.findRenderObject() as RenderBox;
  return box.localToGlobal(Offset.zero);
}


// import 'package:flutter/material.dart';
//
// class SizeConfig {
//   factory SizeConfig() {
//     return _instance;
//   }
//
//   SizeConfig._();
//
//   static SizeConfig _instance;
//   static const int defaultWidth = 1080;
//   static const int defaultHeight = 1920;
//
//   /// Size of the phone in UI Design , px
//   num uiWidthPx;
//   num uiHeightPx;
//
//   /// allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
//   bool allowFontScaling;
//
//   static MediaQueryData _mediaQueryData;
//   static double _screenWidth;
//   static double _screenHeight;
//   static double _pixelRatio;
//   static double _statusBarHeight;
//   static double _bottomBarHeight;
//   static double _textScaleFactor;
//
//   static void init(BuildContext context,
//       {num width = defaultWidth,
//       num height = defaultHeight,
//       bool allowFontScaling = false}) {
//     _instance ??= SizeConfig._();
//     _instance.uiWidthPx = width;
//     _instance.uiHeightPx = height;
//     _instance.allowFontScaling = allowFontScaling;
//
//     final MediaQueryData mediaQuery = MediaQuery.of(context);
//     _mediaQueryData = mediaQuery;
//     _pixelRatio = mediaQuery.devicePixelRatio;
//     _screenWidth = mediaQuery.size.width;
//     _screenHeight = mediaQuery.size.height;
//     _statusBarHeight = mediaQuery.padding.top;
//     _bottomBarHeight = _mediaQueryData.padding.bottom;
//     _textScaleFactor =
//         _mediaQueryData.textScaleFactor.clamp(1.0, 1.5).toDouble();
//   }
//
//   static MediaQueryData get mediaQueryData => _mediaQueryData;
//
//   /// The number of font pixels for each logical pixel.
//   static double get textScaleFactor => _textScaleFactor;
//
//   /// The size of the media in logical pixels (e.g, the size of the screen).
//   static double get pixelRatio => _pixelRatio;
//
//   /// The horizontal extent of this size.
//   static double get screenWidthDp => _screenWidth;
//
//   ///The vertical extent of this size. dp
//   static double get screenHeightDp => _screenHeight;
//
//   /// The vertical extent of this size. px
//   static double get screenWidth => _screenWidth * _pixelRatio;
//
//   /// The vertical extent of this size. px
//   static double get screenHeight => _screenHeight * _pixelRatio;
//
//   /// The offset from the top
//   static double get statusBarHeight => _statusBarHeight;
//
//   /// The offset from the bottom.
//   static double get bottomBarHeight => _bottomBarHeight;
//
//   /// The ratio of the actual dp to the design draft px
//   double get scaleWidth => _screenWidth / uiWidthPx;
//
//   double get scaleHeight => _screenHeight / uiHeightPx;
//
//   double get scaleText => scaleWidth;
//
//   /// Adapted to the device width of the UI Design.
//   /// Height can also be adapted according to this to ensure no deformation ,
//   /// if you want a square
//   num sw(num width) => width * scaleWidth;
//
//   /// Highly adaptable to the device according to UI Design
//   /// It is recommended to use this method to achieve a high degree of adaptation
//   /// when it is found that one screen in the UI design
//   /// does not match the current style effect, or if there is a difference in shape.
//   num sh(num height) => height * scaleHeight;
//
//   ///Font size adaptation method
//   ///@param [fontSize] The size of the font on the UI design, in px.
//   ///@param [allowFontScaling]
//   num sp(num fontSize, {bool allowFontScalingSelf = true}) =>
//       allowFontScalingSelf == null
//           ? (allowFontScaling
//               ? (fontSize * scaleText)
//               : ((fontSize * scaleText) / _textScaleFactor))
//           : (allowFontScalingSelf
//               ? (fontSize * scaleText)
//               : ((fontSize * scaleText) / _textScaleFactor));
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/common/constants/enum/screen_size.enum.dart';

class SizeConfig {
  SizeConfig._();
  static Size screenSize = const Size(0, 0);
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;
  static double _safeAreaHorizontal = 0;
  static double _safeAreaVertical = 0;
  static double safeBlockHorizontal = 0;
  static double safeBlockVertical = 0;

  static void init(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenSize = mediaQueryData.size;
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  static Enum get getScreenSize {
    double ratio = screenWidth / screenHeight;
    if (ratio >= 0.74 && ratio < 1.5) {
      return ScreenSizeEnum.tablet;
    }
    if (ratio >= 0.71 && ratio <= 0.83) {
      return ScreenSizeEnum.ipad;
    }
    return ScreenSizeEnum.phone;
  }

  static bool get isTablet {
    double ratio = screenWidth / screenHeight;
    if (ratio >= 0.74 && ratio < 1.5) {
      return true;
    } else {
      return false;
    }
  }

  static bool get isiPad {
    double ratio = screenWidth / screenHeight;
    if (ratio >= 0.71 && ratio <= 0.83) {
      return true;
    } else {
      return false;
    }
  }

  static bool get isPhone {
    double ratio = screenWidth / screenHeight;
    if (ratio <= 0.70) {
      return true;
    } else {
      return false;
    }
  }
}

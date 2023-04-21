import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_template/common/helpers/size_config.dart';
import 'package:flutter_template/common/utils/file.utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class Helper {
  static Future<XFile?> takeScreenshot({
    required GlobalKey key,
    String fileName = "",
  }) async {
    try {
      final Uint8List? convertedBytes = await convertWidgetToBytes(key: key);

      if (convertedBytes == null) {
        return null;
      }

      //Save image to local temp
      final directory = FileUtil.applicationDir;
      final imagePath =
          await File('$directory/$fileName-${getRandomImageName()}.png')
              .create();
      await imagePath.writeAsBytes(convertedBytes);

      return XFile(imagePath.path);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Uint8List?> convertWidgetToBytes({
    required GlobalKey key,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    //Find renderObject
    var findRenderObject = key.currentContext?.findRenderObject();
    if (findRenderObject == null) {
      return null;
    }
    RenderRepaintBoundary boundary = findRenderObject as RenderRepaintBoundary;
    BuildContext? context = key.currentContext;
    final pixelRatio = MediaQuery.of(context!).devicePixelRatio;
    //Draw render object into image
    ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);

    //Parse ui image to byte data
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    //Parse byte data to unit8list
    return byteData!.buffer.asUint8List();
  }

  static Future<void> shareFiles({required List<XFile> files, required String fileName}) async {
    List<XFile> xFiles = files;
    await Share.shareXFiles(
      xFiles,
      subject: fileName,
      sharePositionOrigin: Rect.fromLTWH(0, 0, SizeConfig.screenWidth, SizeConfig.screenHeight / 2),
    );
  }

  static String getRandomImageName() =>
      DateTime.now().millisecondsSinceEpoch.toString();
}

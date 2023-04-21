// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
//
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/utils/dialog.util.dart';

class ImageUtility {
  
  static Future<File?> cropImage({
    required File imageFile,
    double? width,
    double? height,
  }) async {
    String type = getFileType(imageFile);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 70,
      aspectRatio: CropAspectRatio(ratioX: width ?? 1.0, ratioY: height ?? 1.0),
      compressFormat:
          type == 'png' ? ImageCompressFormat.png : ImageCompressFormat.jpg,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.black,
          toolbarTitle: '',
          hideBottomControls: true,
          toolbarWidgetColor: AppColors.kPrimary,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: '',
          aspectRatioLockEnabled: true,
          hidesNavigationBar: true,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
          resetButtonHidden: true,
        ),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  static String getFileType(var file) {
    List<String> pathInList = file!.path.split('.');
    return pathInList[pathInList.length - 1];
  }

  static Future<File> reduceFileSize(
    File file, {
    int quality = 50,
    int percentage = 50,
  }) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: quality,
      percentage: percentage,
    );
    return compressedFile;
  }

  static Future<void> handelPermissionCamera(BuildContext context) async {
    var status = await Permission.camera.request();
    if (status.isGranted || status.isLimited) {
      return;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: LocaleKeys.texts_ops.tr(),
        confirmButtonText: LocaleKeys.texts_settings.tr(),
        confirmAction: () async{
          await openAppSettings();
        },
        cancelButtonText: LocaleKeys.texts_not_now.tr(),
        textContent: LocaleKeys.permission_camera_deny.tr(),
        cancelAction: () {
          context.router.pop();
        },
      );
    }
  }

  static Future<void> handelPermissionLibrary(BuildContext context) async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
    } else {
      status = await Permission.photos.request();
    }
    if (status.isGranted || status.isLimited) {
      return;
    } else {
      DialogUtil.showCustomDialog(
        context,
        title: LocaleKeys.texts_ops.tr(),
        confirmButtonText: LocaleKeys.texts_settings.tr(),
        confirmAction: () async{
          await openAppSettings();
        },
        cancelButtonText: LocaleKeys.texts_not_now.tr(),
        textContent: LocaleKeys.permission_photo_deny.tr(),
        cancelAction: () {
          context.router.pop();
        },
      );
    }
  }
}

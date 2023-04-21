// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/utils/image.utils.dart';
import 'package:flutter_template/common/utils/toast.util.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:image_picker/image_picker.dart';

enum BottomSheetPicker { camera, gallery, unSplash }

const int maxSize = 2097152; // 2MB

class CustomImagePicker {
  XFile? image;

  static final ImagePicker _picker = ImagePicker();

  static Widget _entity({
    required BuildContext context,
    required String text,
    required String icon,
    required Function() onTap,
  }) {
    return CupertinoActionSheetAction(
      isDefaultAction: true,
      onPressed: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSize.kSpacing16,
              right: AppSize.kSpacing20,
            ),
            child: ImageViewWidget(
              icon,
              height: AppSize.kSpacing24,
              width: AppSize.kSpacing24,
              color: AppColors.kPrimary,
            ),
          ),
          Text(
            text,
            style: AppStyles.body1,
          ),
        ],
      ),
    );
  }

  static Future<File?> _pickFromLibrary({
    required BuildContext context,
    double? width,
    double? height,
  }) async {
    try {
      await ImageUtility.handelPermissionLibrary(context);
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked == null) {
        return null;
      }
      int fileSize = File(picked.path).lengthSync();
      debugPrint(fileSize.toString());
      //Second, Reduce image size
      File reduceFile = await ImageUtility.reduceFileSize(
        File(picked.path),
        percentage: fileSize > maxSize ? 40 : 100,
        quality: fileSize > maxSize ? 80 : 100,
      );
      // Finally, Crop image
      File? file = await ImageUtility.cropImage(
        imageFile: File(reduceFile.path),
        width: width,
        height: height,
      );
      return file;
    } catch (e) {
      ToastUtil.showError(context);
      return null;
    }
  }

  static Future<File?> _pickFromCamera({
    required BuildContext context,
    double? width,
    double? height,
  }) async {
    try {
      await ImageUtility.handelPermissionCamera(context);

      //Pick image first
      final picked = await _picker.pickImage(source: ImageSource.camera);
      if (picked == null) {
        return null;
      }
      int fileSize = File(picked.path).lengthSync();
      // Second, Reduce image size
      File reduceFile = await ImageUtility.reduceFileSize(
        File(picked.path),
        percentage: fileSize > maxSize ? 40 : 100,
        quality: fileSize > maxSize ? 80 : 100,
      );
      // Finally, Crop image
      File? file = await ImageUtility.cropImage(
        imageFile: File(reduceFile.path),
        width: width,
        height: height,
      );
      return file;
    } catch (_) {
      return null;
    }
  }

  static Future<File?> appBottomSheet<String>(
    BuildContext context, {
    double? width,
    double? height,
  }) async {
    final action = CupertinoActionSheet(
      actions: <Widget>[
        _entity(
          context: context,
          onTap: () async =>
              Navigator.of(context).pop(BottomSheetPicker.camera),
          text: LocaleKeys.permission_use_camera.tr(),
          icon: Assets.icons.icCameraIos.path,
        ),
        _entity(
          context: context,
          onTap: () async =>
              Navigator.of(context).pop(BottomSheetPicker.gallery),
          text: LocaleKeys.permission_choose_library.tr(),
          icon: Assets.icons.icPictureIos.path,
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          LocaleKeys.button_cancel.tr(),
          style: AppStyles.body1,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    var sheet = await showCupertinoModalPopup<BottomSheetPicker>(
      context: context,
      builder: (context) => action,
    );

    switch (sheet) {
      case BottomSheetPicker.camera:
        return await _pickFromCamera(context: context, width: width, height: height);
      case BottomSheetPicker.gallery:
        return await _pickFromLibrary(context: context, width: width, height: height);
      default:
        null;
    }
    return null;
  }
}

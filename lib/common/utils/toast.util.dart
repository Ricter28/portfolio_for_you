import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';

abstract class ToastUtil {
  static void showSuccess(
    BuildContext context, {
    String? text,
  }) {
    _showToast(
      context,
      text: text ?? LocaleKeys.texts_success.tr(),
      backgroundColor: AppColors.kGreen5,
    );
  }

  static void showError(
    BuildContext context, {
    String? text,
  }) {
    _showToast(
      context,
      text: text ?? LocaleKeys.message_default_error.tr(),
      backgroundColor: Colors.redAccent,
    );
  }

  static Future<void> _showToast(
    BuildContext context, {
    required String text,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = AppColors.kBlue2,
    TextStyle? textStyle,
  }) async {
    final snackBar = SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.kRadius16),
        ),
      ),
      content: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(AppSize.kSpacing12),
        child: Text(
          text,
          style: textStyle ?? AppStyles.body2,
        ),
      ),
      backgroundColor: backgroundColor,
      padding: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(AppSize.kSpacing12),
      duration: duration,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        snackBar,
      );
  }
}

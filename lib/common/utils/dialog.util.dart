import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/app_rounded_button.widget.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';

class DialogUtil {
  static void hideLoading(BuildContext context) {
    if(context.mounted){
      Navigator.pop(context); 
    }
  }

  static void showLoading(BuildContext context,
      {String? messagge, Color color = AppColors.kProgressIndicator}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: AppSize.kSpacing16),
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppSize.kRadius16),
            ),
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 50,
              minHeight: 30,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator(color: color)
                      : CircularProgressIndicator(
                          strokeWidth: 1.8,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                        ),
                ),
                const SizedBox(width: 16),
                Text(
                  messagge ?? LocaleKeys.texts_please_wait.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 10,
            left: AppSize.kSpacing20,
            right: AppSize.kSpacing20,
            bottom: 10,
          ),
        );
      },
    );
  }

  static void showCustomDialog(
    BuildContext context, {
    bool barrierDismissible = true,
    bool isConfirmDialog = false,
    String? title,
    String? textContent,
    Widget? contentWidget,
    TextStyle? titleStyle,
    TextStyle? textContentStyle,
    TextStyle? confirmButtonTextStyle,
    TextStyle? cancelButtonTextStyle,
    String? cancelButtonText,
    String? confirmButtonText,
    VoidCallback? cancelAction,
    VoidCallback? confirmAction,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
  }) {
    Future.delayed(Duration.zero);
    _commonDialog(
      context,
      barrierDismissible: barrierDismissible,
      isConfirmDialog: isConfirmDialog,
      title: title,
      textContent: textContent,
      contentWidget: contentWidget,
      titleStyle: titleStyle,
      textContentStyle: textContentStyle,
      confirmButtonTextStyle: confirmButtonTextStyle,
      cancelButtonTextStyle: cancelButtonTextStyle,
      cancelButtonText: cancelButtonText,
      confirmButtonText: confirmButtonText,
      cancelAction: cancelAction,
      confirmAction: confirmAction,
      confirmButtonColor: confirmButtonColor,
      cancelButtonColor: cancelButtonColor,
    );
  }

  static void _commonDialog(
    BuildContext context, {
    required bool barrierDismissible,
    required bool isConfirmDialog,
    String? title,
    String? textContent,
    Widget? contentWidget,
    TextStyle? titleStyle,
    TextStyle? textContentStyle,
    TextStyle? confirmButtonTextStyle,
    TextStyle? cancelButtonTextStyle,
    String? cancelButtonText,
    String? confirmButtonText,
    VoidCallback? cancelAction,
    VoidCallback? confirmAction,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
  }) async {
    if (Platform.isIOS) {
      _showDialogOnIos(
        context,
        barrierDismissible,
        isConfirmDialog,
        title,
        textContent,
        contentWidget,
        titleStyle,
        textContentStyle,
        confirmButtonText,
        cancelButtonText,
        confirmButtonColor,
        cancelButtonColor,
        confirmButtonTextStyle,
        cancelButtonTextStyle,
        cancelAction,
        confirmAction,
      );
    } else {
      _showDialogOnAndroid(
        context,
        barrierDismissible,
        isConfirmDialog,
        title,
        textContent,
        contentWidget,
        titleStyle,
        textContentStyle,
        confirmButtonText,
        cancelButtonText,
        confirmButtonColor,
        cancelButtonColor,
        confirmButtonTextStyle,
        cancelButtonTextStyle,
        cancelAction,
        confirmAction,
      );
    }
  }

  static void _showDialogOnAndroid(
    BuildContext context,
    bool barrierDismissible,
    bool isConfirmDialog,
    String? title,
    String? textContent,
    Widget? contentWidget,
    TextStyle? titleStyle,
    TextStyle? textContentStyle,
    String? confirmButtonText,
    String? cancelButtonText,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    TextStyle? confirmButtonTextStyle,
    TextStyle? cancelButtonTextStyle,
    VoidCallback? cancelAction,
    VoidCallback? confirmAction,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kBgDialog.withOpacity(0.95),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          title: title != null
              ? Text(
                  title,
                  textAlign: TextAlign.center,
                  style: titleStyle ?? AppStyles.body1,
                )
              : null,
          content:
              _buildContentDialog(textContent, textContentStyle, contentWidget),
          actions: [
            Row(
              children: [
                if (!isConfirmDialog)
                  Expanded(
                    child: AppRoundedButton(
                      height: 38,
                      onPressed: cancelAction ?? () => Navigator.pop(context),
                      backgroundColor: cancelButtonColor ?? AppColors.kBgColor,
                      child: Text(
                        cancelButtonText ?? '',
                        style: cancelButtonTextStyle ??
                            AppStyles.body1.copyWith(
                              color: cancelButtonColor ??
                                  AppColors.kTextButonCancel,
                            ),
                      ),
                    ),
                  ),
                if (!isConfirmDialog)
                  const SizedBox(
                    width: AppSize.kSpacing12,
                  ),
                Expanded(
                  child: AppRoundedButton(
                    height: 38,
                    onPressed: confirmAction ?? () => Navigator.pop(context),
                    backgroundColor: confirmButtonColor,
                    child: Text(
                      confirmButtonText ?? '',
                      style: confirmButtonTextStyle ??
                          AppStyles.body1.copyWith(
                            color: confirmButtonColor ??
                                AppColors.kTextButonConfirm,
                          ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  static Future<void> _showDialogOnIos(
    BuildContext context,
    bool barrierDismissible,
    bool isConfirmDialog,
    String? title,
    String? textContent,
    Widget? contentWidget,
    TextStyle? titleStyle,
    TextStyle? textContentStyle,
    String? confirmButtonText,
    String? cancelButtonText,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    TextStyle? confirmButtonTextStyle,
    TextStyle? cancelButtonTextStyle,
    VoidCallback? cancelAction,
    VoidCallback? confirmAction,
  ) async {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: titleStyle ?? AppStyles.body1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )
              : null,
          content:
              _buildContentDialog(textContent, textContentStyle, contentWidget),
          actions: <CupertinoDialogAction>[
            if (!isConfirmDialog)
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: cancelAction ?? () => Navigator.pop(context),
                child: Text(
                  cancelButtonText ?? 'Cancel',
                  style: AppStyles.body1.copyWith(
                    color: confirmButtonColor ?? AppColors.kBlack10,
                  ),
                ),
              ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: confirmAction ?? () => Navigator.pop(context),
              child: Text(
                confirmButtonText ?? 'Confirm',
                style: AppStyles.body1.copyWith(
                  color: cancelButtonColor ?? AppColors.kPrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static SingleChildScrollView _buildContentDialog(
    String? textContent,
    TextStyle? textContentStyle,
    Widget? contentWidget,
  ) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          if (textContent != null)
            Text(
              textContent,
              textAlign: TextAlign.center,
              style: textContentStyle,
            ),
          if (contentWidget != null) contentWidget,
        ],
      ),
    );
  }
}

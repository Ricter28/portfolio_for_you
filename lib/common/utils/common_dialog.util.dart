import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';

class CommonDialog {
  static confirmDialog(
    BuildContext context, {
    required String title,
    EdgeInsets? paddingButton,
    String? confirmButtonText,
    String? cancelButtonText,
    String? content,
    String? image,
    required VoidCallback onYesPressed,
    Color? backgroundConfirmColor,
    VoidCallback? onNoPressed,
  }) {
    return dialog(
      context,
      title: title,
      isConfirm: true,
      paddingButton: paddingButton,
      backgroundConfirmColor: backgroundConfirmColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          showWidgetIfRight(
            provison: content != null,
            right: Text(
              content!,
              style: AppStyles.heading6,
            ),
          ),
          showWidgetIfRight(
            provison: image != null,
            right: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ImageViewWidget(
                image!,
                width: double.maxFinite,
                height: 100,
              ),
            ),
          ),
        ],
      ),
      onYesPressed: onYesPressed,
      onNoPressed: onNoPressed,
      cancelButtonText: cancelButtonText,
      confirmButtonText: confirmButtonText,
    );
  }

  static allowDialog(
    BuildContext context, {
    required String title,
    String? confirmButtonText,
    String? content,
    String? image,
    VoidCallback? onYesPressed,
  }) {
    return dialog(
      context,
      title: title,
      titleStyle: AppStyles.heading6,
      isConfirm: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          showWidgetIfRight(
            provison: content != null,
            right: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                content!,
                style: AppStyles.body1,
              ),
            ),
          ),
          showWidgetIfRight(
            provison: image != null,
            right: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: AppSize.kSpacing24,
              ),
              child: ImageViewWidget(
                image!,
                width: double.maxFinite,
                height: 100,
              ),
            ),
          ),
        ],
      ),
      onYesPressed: onYesPressed,
      confirmButtonText: confirmButtonText,
    );
  }

  static dialog(
    BuildContext context, {
    String? title,
    String? confirmButtonText,
    String? cancelButtonText,
    EdgeInsets? paddingButton,
    required Widget body,
    required bool isConfirm,
    bool isShowActions = true,
    TextStyle? titleStyle,
    VoidCallback? onYesPressed,
    VoidCallback? onNoPressed,
    Color? backgroundConfirmColor,
  }) {
    Future.delayed(Duration.zero, () {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.kRadius16),
            ),
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            title: showWidgetIfRight(
                provison: title != null,
                right: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                  child: Text(
                    title!,
                    style: titleStyle ?? AppStyles.heading6,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                )),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [body],
              ),
            ),
            actions: [
              if (isShowActions)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.kSpacing20,
                    vertical: AppSize.kSpacing20,
                  ),
                  child: Row(
                    children: [
                      if (isConfirm)
                        Expanded(
                          child: InkWell(
                            onTap: onNoPressed ?? () => hide(context),
                            borderRadius:
                                BorderRadius.circular(AppSize.kRadius16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.kSpacing12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.kRadius16),
                                border: Border.all(
                                    color: AppColors.kBlack7, width: 1.5),
                              ),
                              child: Text(
                                cancelButtonText ?? 'Discard',
                                style: AppStyles.body1,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        width: isConfirm ? AppSize.kSpacing16 : 0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: onYesPressed ?? () => hide(context),
                          borderRadius:
                              BorderRadius.circular(AppSize.kRadius16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSize.kSpacing12 + 1.5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.kRadius16),
                                color: backgroundConfirmColor ??
                                    AppColors.kPrimary),
                            child: Text(
                              confirmButtonText ?? 'Save',
                              style: AppStyles.body1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      );
    });
  }

  static confirmCupertinoDialog(
    BuildContext context, {
    required String title,
    String? confirmButtonText,
    String? cancelButtonText,
    EdgeInsets? paddingButton,
    required String content,
    TextStyle? titleStyle,
    VoidCallback? onYesPressed,
    VoidCallback? onNoPressed,
    Color? backgroundConfirmColor,
    Color? confirmTextColor,
    Color? cancelTextColor,
  }) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: titleStyle ?? AppStyles.heading6,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          content: Text(content, style: AppStyles.body1),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: onNoPressed ??
                  () {
                    Navigator.pop(context);
                  },
              child: Text(
                cancelButtonText ?? 'Cancel',
                style: AppStyles.body1,
              ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: onYesPressed ??
                  () {
                    Navigator.pop(context);
                  },
              child: Text(
                confirmButtonText ?? 'Confirm',
                style: AppStyles.body1,
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget showWidgetIfRight({
    required bool provison,
    required Widget right,
    Widget left = const SizedBox.shrink(),
  }) {
    return provison ? right : left;
  }

  static hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_template/common/helpers/size_config.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';

void showCommonBottomSheet(
  BuildContext context, {
  required Widget child,
  String? modalTitle,
  Widget? trailing,
  double? radius,
  double? maxHeight,
  Color? backgroundColor,
  VoidCallback? whenComplete,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius ?? AppSize.kRadius12),
        topLeft: Radius.circular(radius ?? AppSize.kRadius12),
      ),
    ),
    constraints: BoxConstraints(
      minHeight: SizeConfig.screenHeight * 0.3,
      maxHeight: maxHeight??SizeConfig.screenHeight * 0.92,
    ),
    backgroundColor: backgroundColor ?? AppColors.kBgColor,
    builder: (builder) {
      return SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildHeaderNotch(modalTitle), Expanded(child: child)],
        ),
      );
    },
  ).whenComplete(() {
    debugPrint('Close Modal Bottom Sheet');
    if (whenComplete != null) {
      whenComplete();
    }
  });
}

Widget _buildHeaderNotch(String? modalTitle) {
  if (modalTitle == null) {
    return Align(
      child: Container(
        width: SizeConfig.screenWidth / 5,
        height: AppSize.kSpacing4,
        margin: const EdgeInsets.symmetric(
          vertical: AppSize.kSpacing12,
        ),
        decoration: BoxDecoration(
          color: AppColors.kBlack2,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
  return SizedBox(
    height: 68,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          child: Container(
            width: SizeConfig.screenWidth / 5,
            height: AppSize.kSpacing4,
            margin: const EdgeInsets.only(top: AppSize.kSpacing12),
            decoration: BoxDecoration(
              color: AppColors.kBlack2,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.kHorizontalSpace,
            vertical: AppSize.kSpacing10,
          ),
          child: Text(
            modalTitle,
            style: AppStyles.body1.copyWith(
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
        ),
        const Divider(
          height: 1,
        )
      ],
    ),
  );
}

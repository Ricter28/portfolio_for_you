import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';

class AppRoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;

  final Color? backgroundColor;
  final Color? disableBackgroundColor;
  final Color? shadowColor;

  final bool isLoading;
  final bool isDisable;

  final Widget? child;
  final EdgeInsetsGeometry margin;
  final BorderSide? borderSide;
  final ShapeBorder? shape;

  const AppRoundedButton({
    super.key,
    required this.onPressed,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation,
    this.backgroundColor,
    this.disableBackgroundColor,
    this.shadowColor,
    this.isDisable = false,
    this.isLoading = false,
    this.child,
    this.borderSide,
    this.margin = EdgeInsets.zero,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppSize.kSpacing50,
      width: width?? double.infinity,
      margin: margin,
      child: MaterialButton(
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppSize.kRadius12,
              ),
            ),
        elevation: elevation,
        color: backgroundColor ?? AppColors.kPrimary,
        onPressed: isDisable ? null : onPressed,
        disabledColor: disableBackgroundColor ?? AppColors.kBlack1,
        child: _buildChild(),
      ),
    );
  }

  Widget? _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: Platform.isIOS
            ? const CupertinoActivityIndicator(color: AppColors.kTextButonConfirm)
            : const CircularProgressIndicator(
                strokeWidth: 1.8,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kTextButonConfirm),
              ),
      );
    }
    return child;
  }
}

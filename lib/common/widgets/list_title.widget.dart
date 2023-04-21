import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    this.prefixIcon,
    this.onTap,
    this.colorIcon,
    required this.title,
    this.subtitle,
    this.suffixWidget,
    this.padding,
  });
  final Widget? prefixIcon;
  final String title;
  final String? subtitle;
  final Widget? suffixWidget;
  final VoidCallback? onTap;
  final Color? colorIcon;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSize.kSpacing16,
              vertical: AppSize.kSpacing16,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            prefixIcon ?? const SizedBox(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.body2.copyWith(
                      color: AppColors.kBlack10,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppStyles.body2,
                    ),
                ],
              ),
            ),
            suffixWidget ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTapPrefixIcon;
  final VoidCallback? onTapSuffixIcon;
  final double? textfieldHeight;
  final FormFieldValidator? validator;
  final TextInputAction? textInputAction;
  final String? errorText;
  final int? maxLines;
  const TextFieldWidget({
    super.key,
    this.hintText = '',
    this.onChanged,
    this.onTapPrefixIcon,
    this.onSaved,
    this.prefixIcon,
    required this.controller,
    this.label = '',
    this.onFieldSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.textfieldHeight,
    this.validator,
    this.textInputAction,
    this.errorText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.body2.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            height: 16 / 12,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        const SizedBox(
          height: AppSize.kSpacing10,
        ),
        TextFormField(
          maxLines: maxLines,
          decoration: _textFieldInputdecoration(context),
          cursorColor: AppColors.kBlack10,
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          style: AppStyles.body1,
          textInputAction: textInputAction,
          onChanged: onChanged,
        ),
        const SizedBox(
          height: AppSize.kSpacing8,
        ),
        Text(
          errorText ?? '',
          style: AppStyles.body2.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 16 / 12,
            color: AppColors.kRed5,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
      ],
    );
  }

  InputDecoration _textFieldInputdecoration(BuildContext context) {
    return InputDecoration(
      prefixIcon: prefixIcon != null
          ? GestureDetector(
              onTap: onTapPrefixIcon ?? () {},
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: prefixIcon,
              ),
            )
          : null,
      prefixIconConstraints: const BoxConstraints(),
      suffixIconConstraints: const BoxConstraints(),
      suffixIcon: suffixIcon != null
          ? GestureDetector(
              onTap: onTapSuffixIcon ?? () {},
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: suffixIcon,
              ),
            )
          : null,
      hintText: hintText,
      constraints: const BoxConstraints(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSize.kHorizontalSpace,
        vertical: AppSize.kSpacing10,
      ),
      hintStyle: AppStyles.body1.copyWith(
        color: AppColors.kBlack5,
      ),
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildFocusedBorder(),
      errorBorder: _buildErrorBorder(),
    );
  }

  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kPrimary,
      ),
      borderRadius: BorderRadius.circular(
        AppSize.kRadius8,
      ),
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kRed5,
      ),
      borderRadius: BorderRadius.circular(
        AppSize.kRadius8,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kBlack3,
      ),
      borderRadius: BorderRadius.circular(
        AppSize.kRadius8,
      ),
    );
  }
}

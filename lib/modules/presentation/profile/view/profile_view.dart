import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/app_rounded_button.widget.dart';
import 'package:flutter_template/common/widgets/app_text_form_field.widget.dart';
import 'package:flutter_template/common/widgets/dropdown_widet.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';
import 'package:flutter_template/common/widgets/loading_dot.widget.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/modules/presentation/profile/bloc/profile_bloc.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileBloc profileBloc;
  String avatar = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileBloc = ProfileBloc();
    profileBloc.add(const InitProfileEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.kBlack5,
        ),
        backgroundColor: AppColors.kBgColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => profileBloc,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            bloc: profileBloc,
            builder: (context, state) {
              if (state is LoadingProfileState) {
                return const Center(
                  child: LoadingDot(
                    dotColor: AppColors.kPrimary,
                    size: 12,
                  ),
                );
              }
              if (state is LoadedProfileState) {
                if (state.user.avatar != null) {
                  avatar = state.user.avatar!;
                }
                _nameController.text = state.user.name ?? '';
                _emailController.text = state.user.email ?? '';
                _phoneController.text = state.user.phone ?? '';
              }
              return _buildBody(context);
            },
          ),
        ),
      ),
    );
  }

  Column _buildBody(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildForm(),
        const Spacer(),
        AppRoundedButton(
          onPressed: () async {
            profileBloc.add(
              UpdateProfileEvent(
                UserModel(
                  avatar: avatar,
                  name: _nameController.text.trim(),
                  email: _emailController.text.trim(),
                  phone: _phoneController.text.trim(),
                ),
                context,
              ),
            );
          },
          margin: const EdgeInsets.symmetric(
              horizontal: 20, vertical: AppSize.kSpacing20),
          child: Text(
            'Save',
            style: AppStyles.button2.copyWith(color: AppColors.kBgColor),
          ),
        )
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        const SizedBox(height: 18),
        _buildAvatar(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.kSpacing20,
          ),
          child: TextFieldWidget(
            label: 'Your name',
            keyboardType: TextInputType.text,
            hintText: 'Lucas Eden',
            controller: _nameController,
            textInputAction: TextInputAction.next,
            suffixIcon: _nameController.text.isNotEmpty
                ? const Icon(Icons.clear)
                : null,
            onTapSuffixIcon: () {
              _nameController.clear();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.kSpacing20,
          ),
          child: TextFieldWidget(
            label: 'Your email',
            keyboardType: TextInputType.emailAddress,
            hintText: 'lucas.eden@gmail.com',
            controller: _emailController,
            textInputAction: TextInputAction.next,
            suffixIcon: _emailController.text.isNotEmpty
                ? const Icon(Icons.clear)
                : null,
            onTapSuffixIcon: () {
              _emailController.clear();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.kSpacing20,
          ),
          child: TextFieldWidget(
            label: 'Your phone number',
            keyboardType: TextInputType.number,
            hintText: '+912 4942 9999',
            controller: _phoneController,
            textInputAction: TextInputAction.next,
            suffixIcon: _phoneController.text.isNotEmpty
                ? const Icon(Icons.clear)
                : null,
            onTapSuffixIcon: () {
              _phoneController.clear();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      builder: (context, state) {
        if (state is ChooseAvatarProfileState) {
          avatar = state.avatar.isNotEmpty ? state.avatar : avatar;
        }
        return GestureDetector(
          onTap: () {
            profileBloc.add(ChooseAvatarProfileEvent(context));
          },
          child: ImageViewWidget(
            avatar,
            width: 158,
            height: 158,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(158),
          ),
        );
      },
    );
  }
}

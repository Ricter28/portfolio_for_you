import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:flutter_template/common/constants/app_mockup.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/modules/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';
import 'package:flutter_template/modules/presentation/facebook/bloc/app_setting.dart';
import 'package:flutter_template/router/app_routes.dart';

typedef OnSelectedTab = Function(int index);
typedef OnCompletedSearch = Function(String keyWork);

class SliveAppbarView extends StatefulWidget {
  final OnSelectedTab onSelectedTab;
  final OnCompletedSearch onCompletedSearch;
  final UserModel? user;

  const SliveAppbarView({
    super.key,
    required this.onSelectedTab,
    required this.onCompletedSearch,
    required this.user,
  });

  @override
  State<SliveAppbarView> createState() => _SliveAppbarViewState();
}

class _SliveAppbarViewState extends State<SliveAppbarView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isShowSearch = false;
  late TextEditingController searchController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.5,
      backgroundColor: AppColors.kBgColor,
      pinned: true,
      stretch: true,
      expandedHeight: 158,
      flexibleSpace: _buildFlexibleSpaceBar(),
      title: _buildTitle(),
      actions: _buildActions,
      bottom: _buildBottom(),
      titleTextStyle: AppStyles.subtitle1.copyWith(
        color: Colors.red,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  PreferredSize _buildBottom() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSize.kSpacing16),
        alignment: Alignment.centerLeft,
        child: _buildTabBar(),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      isScrollable: true,
      splashFactory: NoSplash.splashFactory,
      padding: const EdgeInsets.only(right: AppSize.kSpacing20),
      indicatorPadding: const EdgeInsets.only(right: AppSize.kSpacing20),
      labelPadding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      controller: tabController,
      labelStyle: AppStyles.subtitle1,
      unselectedLabelStyle: AppStyles.subtitle1,
      labelColor: AppColors.kPrimary,
      unselectedLabelColor: AppColors.kBlack7,
      onTap: widget.onSelectedTab,
      indicator: const UnderlineTabIndicator(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(2),
          topRight: Radius.circular(2),
        ),
        borderSide: BorderSide(
          width: 2,
          color: AppColors.kPrimary,
        ),
      ),
      splashBorderRadius: BorderRadius.circular(AppSize.kRadius16),
      tabs: _buildTabs,
    );
  }

  List<Widget> get _buildTabs {
    return <Widget>[
      const Padding(
        padding: EdgeInsets.only(right: AppSize.kSpacing20),
        child: Tab(
          text: 'Catalog and tips',
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(right: AppSize.kSpacing20),
        child: Tab(
          text: 'Home',
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(right: AppSize.kSpacing20),
        child: Tab(
          text: 'Spotlight',
        ),
      ),
    ];
  }

  List<Widget> get _buildActions {
    if (isShowSearch) {
      return [
        GestureDetector(
          onTap: () {
            widget.onCompletedSearch(searchController.text.trim());
            setState(() {
              isShowSearch = !isShowSearch;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.kSpacing18),
            child: Text(
              LocaleKeys.appbar_done.tr(),
              style: AppStyles.subtitle2.copyWith(
                color: AppColors.kPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSize.kSpacing18),
      ];
    }
    return [
      IconButton(
        onPressed: () {
          setState(() {
            isShowSearch = !isShowSearch;
          });
        },
        splashColor: Colors.transparent,
        icon:
            Assets.icons.icSearch.svg(width: 20, height: 20, fit: BoxFit.cover),
      ),
      BlocProvider.value(
        value: getIt<AuthBloc>(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                context.router.pushNamed(Routes.profile);
              },
              splashColor: Colors.transparent,
              icon: ImageViewWidget(
                widget.user?.avatar??defaultAvatar,
                borderRadius: BorderRadius.circular(28),
                fit: BoxFit.cover,
                width: 32,
                height: 32,
              ),
            );
          },
        ),
      ),
      const SizedBox(width: AppSize.kSpacing18),
    ];
  }

  Row _buildTitle() {
    if (isShowSearch) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isShowSearch = !isShowSearch;
              });
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 12, 12),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.kBlack7,
                size: 18,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: AppColors.kBlack5,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                hintText: LocaleKeys.appbar_search.tr(),
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Text(
          widget.user?.name == null ? 'Welcome!':'Hello! ${widget.user?.name}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.subtitle1.copyWith(
            color: AppColors.kBlack,
            fontWeight: FontWeight.w900,
          ),
        )
      ],
    );
  }

  Widget _buildFlexibleSpaceBar() {
    return const FlexibleSpaceBar(
      background: SafeArea(
        child: ListTile(
          contentPadding:
             EdgeInsets.only(top: 48, left: AppSize.kSpacing16),
          title: Text(
            appName,
            style: TextStyle(
              color: AppColors.kBlack,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            sologan,
            style: TextStyle(
              color: AppColors.kBlack5,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 16 / 12,
            ),
          ),
        ),
      ),
      centerTitle: false,
      titlePadding: EdgeInsets.only(left: AppSize.kSpacing16),
    );
  }
}

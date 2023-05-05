import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/constants/enum/app_index.enum.dart';
import 'package:flutter_template/common/helpers/size_config.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/app_rounded_button.widget.dart';
import 'package:flutter_template/common/widgets/card_data.widget.dart';
import 'package:flutter_template/common/widgets/image_view.widget.dart';
import 'package:flutter_template/common/widgets/loading_dot.widget.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/modules/presentation/catalog/view/catalog_view.dart';
import 'package:flutter_template/modules/presentation/home/bloc/home_bloc.dart';
//
import 'package:flutter_template/modules/presentation/home/slive_appbar.view.dart';
import 'package:flutter_template/router/app_routes.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeBloc homeBloc;
  int tabIndex = HomeIndexEnum.catalogTag;
  bool isShowSearch = false;

  @override
  void initState() {
    homeBloc = getIt<HomeBloc>();
    homeBloc.add(const InitHomeEvent());
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => homeBloc,
        child: CustomScrollView(
          slivers: <Widget>[
            _buildHeader(),
            _buildListCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.pushNamed(Routes.createCard);
        },
        backgroundColor: AppColors.kPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  BlocBuilder<HomeBloc, HomeState> _buildHeader() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is LoadedHomeState) {
          return SliveAppbarView(
            onSelectedTab: (index) => onSelectedTab(index),
            onCompletedSearch: (value) {
              homeBloc.add(SearchEvent(keywork: value));
            },
            user: state.user,
          );
        }
        return SliveAppbarView(
          onSelectedTab: (index) => onSelectedTab(index),
          onCompletedSearch: (value) {
            homeBloc.add(SearchEvent(keywork: value));
          },
          user: null,
        );
      },
    );
  }

  BlocBuilder<HomeBloc, HomeState> _buildListCard() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if(tabIndex == HomeIndexEnum.catalogTag){
        return CatalogView();
      }
      if (state is LoadedHomeState) {
        if (state.cards.isEmpty) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    ImageViewWidget(
                      Assets.images.emtyData.path,
                      width: SizeConfig.screenWidth * 0.8,
                      height: 350,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppSize.kSpacing20),
                      child: Text(
                        "Looks like you don't have any data yet, let's start with your first product👇",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: AppRoundedButton(
                        onPressed: () {
                          context.router.pushNamed(Routes.createCard);
                        },
                        child: Text(
                          'Create your first card',
                          style: AppStyles.body1
                              .copyWith(color: AppColors.kBgDialog),
                        ),
                      ),
                    )
                  ],
                );
              },
              childCount: 1,
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (state.cards[index].isSpotlight == '1' && tabIndex == HomeIndexEnum.messageTab) {
                return CardItemWidget(
                  cardModel: state.cards[index],
                );
              }
              if (tabIndex == HomeIndexEnum.activityTab) {
                return CardItemWidget(
                  cardModel: state.cards[index],
                );
              }
              return const SizedBox();
            },
            childCount: state.cards.length,
          ),
        );
      }
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: AppSize.kSpacing40),
              child: const LoadingDot(
                dotColor: AppColors.kPrimary,
              ),
            );
          },
          childCount: 1,
        ),
      );
    });
  }

  onSelectedTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  onChangeSearchAction() {
    setState(() {
      isShowSearch = !isShowSearch;
    });
  }
}

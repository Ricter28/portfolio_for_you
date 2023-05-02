import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/data/model/tip_detail.model.dart';
//
import 'package:flutter_template/modules/presentation/auth/view/splash.view.dart';
import 'package:flutter_template/modules/presentation/auth/view/login.view.dart';
import 'package:flutter_template/modules/presentation/catalog/view/catalog_view.dart';
import 'package:flutter_template/modules/presentation/catalog/view/tip_detail_view.dart';
import 'package:flutter_template/modules/presentation/create_card/view/create_card_view.dart';
import 'package:flutter_template/modules/presentation/edit_card/view/edit_card_view.dart';
import 'package:flutter_template/modules/presentation/facebook/view/facebook_view.dart';
import 'package:flutter_template/modules/presentation/facebook/view/intro_facebook_view.dart';
import 'package:flutter_template/modules/presentation/home/home.view.dart';
import 'package:flutter_template/modules/presentation/home/onboading.view.dart';
import 'package:flutter_template/modules/presentation/profile/view/profile_view.dart';
import 'package:flutter_template/modules/presentation/components/image_view/image_view.dart';
import 'package:flutter_template/router/app_routes.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: 'View,Route')  
class AppRouter extends _$AppRouter {      
    
  @override      
  final List<AutoRoute> routes = [      
      AutoRoute(path: Routes.splash, page: SplashRoute.page, initial: true),
      AutoRoute(path: Routes.login, page: LoginRoute.page),
      AutoRoute(path: Routes.home, page: HomeRoute.page),
      AutoRoute(path: Routes.profile, page: ProfileRoute.page) ,
      AutoRoute(path: Routes.imageView, page: ImageRoute.page),
      AutoRoute(path: Routes.createCard, page: CreateCardRoute.page),
      AutoRoute(path: Routes.editCard, page: EditCardRoute.page),
      AutoRoute(path: Routes.onboarding, page: OnboardingRoute.page),
      AutoRoute(path: Routes.catalog, page: CatalogRoute.page),
      AutoRoute(path: Routes.tipDetail, page: TipDetailRoute.page),
      //
      AutoRoute(path: Routes.introFace, page: IntroFacebookRoute.page),
      AutoRoute(path: Routes.face, page: FacebookRoute.page),
   ];   
 }               